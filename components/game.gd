extends Node2D

var Square = preload("res://components/square.tscn");
var timer = Timer.new();

func _ready():
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "create_item")
	add_child(timer)

func start_game(life):
	$Life.update_hearts(life);
	timer.start();

func create_item():
	var square = Square.instance();
	square.position = $Spawn.position;
	square.connect("loose_life", self, "on_life_loose")
	add_child(square);

func on_life_loose():
	$Life.remove_heart();
	
