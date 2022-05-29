extends KinematicBody2D

var gravity = 400;
var velocity = Vector2.ZERO

func _ready():
	connect("input_event", self, "_on_input_event");

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_input_event(viewport, event, shape_idx):
	if (event is InputEventScreenTouch and event.pressed):
		item_touched();

func item_touched():
	pass;
