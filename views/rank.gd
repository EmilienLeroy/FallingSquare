extends Node2D

signal home;
signal restart;

var data = {};

func _ready():
	if (!data.rank):
		push_error('No rank !');
	
	$Home.connect("button_down", self, "_on_home");
	$Restart.connect("button_down", self, "_on_restart");

	$Name.text = data.name;
	$Value.text = '#' + str(data.rank);
	pass

func _on_home():
	emit_signal("home");

func _on_restart():
	emit_signal("restart");
