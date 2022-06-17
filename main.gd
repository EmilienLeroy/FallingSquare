extends Node2D

var HomeView = preload("res://views/home.tscn");
var GameView = preload("res://views/game.tscn");
var LoseView = preload("res://views/lose.tscn");
var AboutView = preload("res://views/about.tscn");

var current;

func _ready():
	current = create_home();
	add_child(current);
	pass

func create_home():
	var home = HomeView.instance();
	
	home.connect("play", self, 'on_play');
	home.connect("info", self, 'on_info');
	
	return home;

func create_about():
	var about = AboutView.instance();
	
	about.connect("back", self, 'on_home');
	
	return about;

func create_game():
	var game = GameView.instance(); 
	
	game.set_life(3);
	game.connect("lose", self, "on_lose");
	
	return game;
	
func create_lose(score):
	var lose = LoseView.instance();
	
	lose.connect("restart", self, "on_play");
	lose.connect("home", self, "on_home");
	lose.score = score;
	
	return lose;

func update_current_view(view):
	$Fade.fade_in();
	yield($Fade/Animation, "animation_finished");
	
	current.queue_free();
	add_child(view);
	current = view;
	
	$Fade.fade_out();
	yield($Fade/Animation, "animation_finished");

func on_home():
	update_current_view(create_home());
	
func on_info():
	update_current_view(create_about());

func on_play():
	update_current_view(create_game());

func on_lose(score):
	update_current_view(create_lose(score));
