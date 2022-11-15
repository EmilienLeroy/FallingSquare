extends Node2D

signal lose;

var Square = preload("res://components/square.tscn");
var Bomb = preload("res://components/bomb.tscn");
var Restore = preload("res://components/restore.tscn");
var Reset = preload("res://components/reset.tscn");
var Multiply = preload("res://components/multiply.tscn");
var Multi = preload("res://components/multi.tscn");
var Explosion = preload("res://components/explosion.tscn");

const DEFAULT_SIZE = 1.2;
const DEFAULT_TIME = 1.5;

var timer = Timer.new();
var lifes;
var max_lifes;
var score = 0;
var combo = 0;
var shake_amount = 10;
var shake = false;
var already_reset = false;
var size = DEFAULT_SIZE;
var interval = DEFAULT_TIME;

func _process(delta):
	if (!shake):
		return;

	$ShakeCamera.set_offset(Vector2(
		rand_range(-1, 1) * shake_amount,
		rand_range(-1, 1) * shake_amount
	))

func _ready():
	randomize();
	
	timer.set_wait_time(interval);
	timer.set_one_shot(false);
	timer.connect("timeout", self, "create_item");
	
	add_child(timer);
	
	timer.start();

func set_life(life):
	lifes = life;
	max_lifes = life;
	$Front/Life.update_hearts(life);

# Get randomly an item.
# The current probability 
# to get theses items are :
#  - Restore: 5%
#  - Multi: 10%
#  - Bomb: 10%
#  - Multiply: 5%
#  - Reset: 2% and life =< 2
#  - Square: 68%
#
# Reset can be used once after it will 
# never spawn again during the game.
func get_random_item():
	var random_float = randf();

	if random_float < 0.05:
		return Restore;
	
	if random_float < 0.15:
		return Multi;
	
	if random_float < 0.25:
		return Bomb;
	
	if random_float < 0.30:
		return Multiply;
		
	if random_float < 0.32 and lifes <= 2 and !already_reset:
		return Reset;
 
	return Square;

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
	item.connect("touched_under_zone", self, "on_item_touched");
	item.connect("reset_items", self, "on_item_reset");
	
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
	combo = combo + item.combo;
	score = score + (item.value * combo);
	
	$Combo.combo = combo;
	$Score.score = score;
	
	explosion(item.position);

func on_life_added():
	if (max_lifes <= lifes):
		return
	
	lifes = lifes + 1;
	$Front/Life.add_heart();

func on_life_loose():
	lifes = lifes - 1;
	combo = 0;
	
	$Combo.combo = combo;
	$Front/Life.remove_heart();
	
	shake_camera();
	
	if (lifes == 0):
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("lose", score);
	

func on_item_reset():
	size = DEFAULT_SIZE;
	interval = DEFAULT_TIME;
	already_reset = true;
	
func shake_camera():
	shake = true;
	
	yield(get_tree().create_timer(0.3), "timeout");
	
	shake = false;
	$ShakeCamera.set_offset(Vector2(0, 0))

func explosion(pos):
	var explosion = Explosion.instance();
	add_child(explosion);
	explosion.emit(pos);
