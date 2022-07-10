extends Node2D

signal back;

func _ready():
	$Version.text = "Version " + get_version();
	$Back.connect("button_down", self, "_on_back_down");
	pass 

func _on_back_down():
	emit_signal("back");


func get_version():
	return ProjectSettings.get_setting("application/config/version");
