extends Node2D

signal back;

func _ready():
	$Back.connect("button_down", self, "_on_back_down");
	pass 

func _on_back_down():
	emit_signal("back");

