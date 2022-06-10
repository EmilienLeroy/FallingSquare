extends Node2D

var HomeView = preload("res://views/home.tscn");
var GameView = preload("res://components/game.tscn");

var current;

func _ready():
	current = create_home();
	pass


func create_home():
	var home = HomeView.instance();
	add_child(home);
	home.connect("play", self, 'on_play')
	return home;

func create_game():
	var game = GameView.instance(); 
	add_child(game);
	game.start_game(3);
	
	return game;
	
func on_play():
	current.queue_free();
	current = create_game();
