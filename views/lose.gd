extends Node2D

signal restart;
signal home;
signal save;

var score = 0;

func _ready():
	$Home.connect("button_down", self, "_on_home");
	$Restart.connect("button_up", self, "_on_restart");
	$Save.connect("button_down", self, "_on_save");
	$Value.text = str(score);
	pass

func _on_home():
	emit_signal("home");
	
func _on_restart():
	emit_signal("restart");

func _on_save():
	emit_signal("save", score);
