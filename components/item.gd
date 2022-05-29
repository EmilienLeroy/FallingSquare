extends KinematicBody2D

onready var sprite = $Sprite;

export var gravity = 400;
var velocity = Vector2.ZERO;
var is_under_zone = false;

func _ready():
	connect("input_event", self, "_on_input_event");

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_input_event(viewport, event, shape_idx):
	if (event is InputEventScreenTouch and event.pressed and is_under_zone):
		item_touched();

func update_color(color):
	sprite.material = sprite.material.duplicate()
	sprite.material.set_shader_param("color", color)

func enter_zone():
	pass;

func item_touched():
	pass;
