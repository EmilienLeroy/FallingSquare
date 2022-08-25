extends Node2D

signal cancel;

var score = 0;

func _ready():
	$Cancel.connect("button_down", self, "_on_cancel");

func _on_cancel():
	emit_signal("cancel", score);
