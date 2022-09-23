extends Node2D

signal play;
signal leaderboard;
signal info;

func _ready():
	$Play.connect("button_down", self, "_on_play_down");
	$About.connect("button_down", self, "_on_info_down");
	$Leaderboard.connect("button_down", self, "_on_leaderboard_down");
	pass

func _on_play_down():
	emit_signal("play");

func _on_info_down():
	emit_signal("info");

func _on_leaderboard_down():
	emit_signal("leaderboard");
