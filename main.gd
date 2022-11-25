extends Node2D

var HomeView = preload("res://views/home.tscn");
var GameView = preload("res://views/game.tscn");
var LoseView = preload("res://views/lose.tscn");
var AboutView = preload("res://views/about.tscn");
var SaveView = preload("res://views/save.tscn");
var RankView = preload("res://views/rank.tscn");
var OptionsView = preload("res://views/options.tscn");
var LeaderboardView = preload("res://views/leaderboard.tscn");
var StatisticView = preload("res://views/statistics.tscn");

var current;

func _ready():
	current = create_home();
	add_child(current);
	pass

func create_home():
	var home = HomeView.instance();
	
	home.connect("play", self, 'on_play');
	home.connect("info", self, 'on_info');
	home.connect("options", self, 'on_options');
	home.connect("statistics", self, 'on_statistics');
	home.connect("leaderboard", self, 'on_leaderboard');
	
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
	
func create_lose(score, stats, save = false):
	var lose = LoseView.instance();
	
	lose.connect("restart", self, "on_play");
	lose.connect("home", self, "on_home");
	lose.connect("save", self, "on_save");
	
	lose.score = score;
	lose.stats = stats;
	lose.save = save;
	
	return lose;

func create_save(score, stats):
	var save = SaveView.instance();
	
	save.connect("cancel", self, "on_lose");
	save.connect("send", self, "on_rank");
	
	save.score = score;
	save.stats = stats;
	
	return save;

func create_rank(data):
	var rank = RankView.instance();
	
	rank.connect("restart", self, "on_play");
	rank.connect("home", self, "on_home");
	rank.data = data;
	
	return rank;

func create_leaderboard():
	var leaderboard = LeaderboardView.instance();
	
	leaderboard.connect("back", self, "on_home");
	
	return leaderboard;

func create_options():
	var options = OptionsView.instance();
	
	options.connect("back", self, "on_home");
	
	return options;
	
func create_statistics():
	var statistics = StatisticView.instance();
	
	statistics.connect("back", self, "on_home");
	
	return statistics;

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
	
func on_options():
	update_current_view(create_options());
	
func on_statistics():
	update_current_view(create_statistics());

func on_lose(score, stats, save = false):
	update_current_view(create_lose(score, stats, save));

func on_save(score, stats):
	update_current_view(create_save(score, stats));

func on_rank(data):
	update_current_view(create_rank(data));

func on_leaderboard():
	update_current_view(create_leaderboard());
