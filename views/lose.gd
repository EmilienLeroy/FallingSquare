extends Node2D

signal restart
signal home

var score = 0;

func _ready():
	$Home.connect("button_down", self, "_on_home");
	$Restart.connect("button_up", self, "_on_restart");
	$Value.text = str(score);
	pass

func _on_home():
	emit_signal("home");
	
func _on_restart():
	emit_signal("restart");
