extends Node2D

signal play;
signal info;

func _ready():
	$Play.connect("button_down", self, "_on_play_down");
	$Button/Info.connect("button_down", self, "_on_info_down");
	pass

func _on_play_down():
	emit_signal("play");

func _on_info_down():
	emit_signal("info");
