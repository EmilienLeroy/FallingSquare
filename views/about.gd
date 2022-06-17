extends Node2D

signal back;

func _ready():
	$Version.text = "Version " + get_version();
	$Back.connect("button_down", self, "_on_back_down");
	pass 

func _on_back_down():
	emit_signal("back");


func get_version():
	var config = ConfigFile.new();	
	var err = config.load("res://version.cfg");
	
	if err != OK:
		return
		
	return config.get_value(config.get_sections()[0], "version");
