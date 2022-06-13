extends Node2D

signal lose;
var Square = preload("res://components/square.tscn");
var Bomb = preload("res://components/bomb.tscn");
var Restore = preload("res://components/restore.tscn");
var items = [Square, Bomb, Restore];
var timer = Timer.new();
var lifes;
var max_lifes;
var score = 0;

func _ready():
	timer.set_wait_time(1.0);
	timer.set_one_shot(false);
	timer.connect("timeout", self, "create_item");
	
	add_child(timer);
	
	timer.start();

func set_life(life):
	lifes = life;
	max_lifes = life;
	$Front/Life.update_hearts(life);

func create_item():
	var scale = rand_range(0.5, 1.2);
	var rotation = rand_range(-5, 5);
	var item = items[randi() % items.size()].instance();
	
	update_spawn_time();
	update_spawn_position();
	
	item.position = $Spawn.position;
	item.scale = Vector2(scale, scale);
	item.set_speed_rotation(rotation);
	item.connect("add_life", self, "on_life_added");
	item.connect("loose_life", self, "on_life_loose");
	item.connect("touched_under_zone", self, "on_item_touched")
	
	add_child(item);

func update_spawn_time():
	var time = rand_range(0.5, 1);

	timer.set_wait_time(time);

func update_spawn_position():
	var positionX = rand_range(30, 300);
	var positionY = 0;
	
	$Spawn.position = Vector2(positionX, positionY);


func on_item_touched():
	score = score + 1;
	$Score.score = score;
	
func on_life_added():
	print(max_lifes)
	print(lifes)
	if (max_lifes <= lifes):
		return
	
	lifes = lifes + 1;
	$Front/Life.add_heart();

func on_life_loose():
	lifes = lifes - 1;
	$Front/Life.remove_heart();
	
	if (lifes == 0):
		yield(get_tree().create_timer(0.3), "timeout")
		emit_signal("lose", score);
	
	
