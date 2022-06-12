extends Node2D

signal lose;
var Square = preload("res://components/square.tscn");
var timer = Timer.new();
var lifes;

func _ready():
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "create_item")
	add_child(timer)
	timer.start();

func set_life(life):
	lifes = life;
	$Life.update_hearts(life);

func create_item():
	var square = Square.instance();
	square.position = $Spawn.position;
	square.connect("loose_life", self, "on_life_loose")
	add_child(square);

func on_life_loose():
	lifes = lifes - 1;
	$Life.remove_heart();
	
	if (lifes == 0):
		emit_signal("lose");
	
	
