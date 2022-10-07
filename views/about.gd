extends Node2D

signal back;

func _ready():
	$Back.connect("button_down", self, "_on_back_down");
	$Github.connect("button_down", self, "_on_github_down");
	$Icons8.connect("button_down", self, "_on_icons8_down");
	pass 

func _on_back_down():
	emit_signal("back");

func _on_github_down():
	OS.shell_open('https://github.com/EmilienLeroy/FallingSquare');

func _on_icons8_down():
	OS.shell_open('https://icons8.com');
