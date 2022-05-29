extends Area2D


func _ready():
	connect("body_entered", self, "_on_object_enter")
	pass;

func _on_object_enter(target):
	# set target as "in the zone" !
	pass;
