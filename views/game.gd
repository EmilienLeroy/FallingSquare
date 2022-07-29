extends Node2D

signal lose;

var Square = preload("res://components/square.tscn");
var Bomb = preload("res://components/bomb.tscn");
var Restore = preload("res://components/restore.tscn");

var timer = Timer.new();
var lifes;
var max_lifes;
var score = 0;
var shake_amount = 10;
var shake = false;
var size = 1.2;
var interval = 1.5;

func _process(delta):
	if (!shake):
		return;

	$ShakeCamera.set_offset(Vector2(
		rand_range(-1, 1) * shake_amount,
		rand_range(-1, 1) * shake_amount
	))

func _ready():
	timer.set_wait_time(interval);
	timer.set_one_shot(false);
	timer.connect("timeout", self, "create_item");
	
	add_child(timer);
	
	timer.start();

func set_life(life):
	lifes = life;
	max_lifes = life;
	$Front/Life.update_hearts(life);

func get_random_item():
	var random_float = randf();

	if random_float < 0.8:
		return Square;
	
	if random_float < 0.9:
		return Bomb;

	return Restore;

func create_item():
	var rotation = rand_range(-1, 1);
	var item = get_random_item().instance();
	
	if (size > 0.2):
		size = size - 0.01;
	
	update_spawn_time();
	update_spawn_position();
	
	item.position = $Spawn.position;
	item.scale = Vector2(size, size);
	item.set_speed_rotation(rotation);
	item.connect("add_life", self, "on_life_added");
	item.connect("loose_life", self, "on_life_loose");
	item.connect("touched_under_zone", self, "on_item_touched")
	
	add_child(item);

func update_spawn_time():
	
	if (interval > 0.7):
		interval = interval - 0.1;

	timer.set_wait_time(interval);

func update_spawn_position():
	var minX = 30;
	var maxX = 300;
	var minDiff = maxX / 3.5;
	var positionX = rand_range(minX, maxX);
	var positionY = 0;
	
	# This prevent update of the spawn position
	# to a position very close of the previous position.
	# Without this if the item is so big and the spawing time so little
	# items can be stucks on the top of the screen.
	while(abs(positionX - $Spawn.position.x) < minDiff):
		positionX = rand_range(minX, maxX);
	
	$Spawn.position = Vector2(positionX, positionY);

func on_item_touched(item):
	score = score + item.value;
	$Score.score = score;
	
func on_life_added():
	if (max_lifes <= lifes):
		return
	
	lifes = lifes + 1;
	$Front/Life.add_heart();

func on_life_loose():
	lifes = lifes - 1;
	$Front/Life.remove_heart();
	shake_camera();
	
	if (lifes == 0):
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("lose", score);
	

func shake_camera():
	shake = true;
	
	yield(get_tree().create_timer(0.3), "timeout");
	
	shake = false;
	$ShakeCamera.set_offset(Vector2(0, 0))
