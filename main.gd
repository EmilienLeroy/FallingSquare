extends Node2D

var Game = preload("res://components/game.tscn");

func _ready():
	create_game();
	pass


func create_game():
	var game = Game.instance(); 
	add_child(game);
	game.start_game(3);
	pass
