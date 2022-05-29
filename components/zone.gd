extends Area2D

func _ready():
	connect("body_entered", self, "_on_object_enter")
	pass;

func _on_object_enter(target):
	if ("is_under_zone" in target):
		target.is_under_zone = true;
		target.enter_zone();
		
	pass;
