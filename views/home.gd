extends Node2D

signal play;

func _ready():
	$Play.connect("button_down", self, "_on_play_down");
	pass

func _on_play_down():
	emit_signal("play");
