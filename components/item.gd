extends KinematicBody2D

signal touched_under_zone;

onready var sprite = $Sprite;
export var gravity = 400;

var speed_rotation = 0;
var velocity = Vector2.ZERO;
var is_under_zone = false;
var touch_under_zone = false;
var value setget , get_value;
var combo setget , get_combo;
var is_multi setget , get_is_multi;

func _ready():
	connect("input_event", self, "_on_input_event");
	$Animation.play("fade");
	
func _process(delta):
	rotation += speed_rotation * delta;

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_input_event(viewport, event, shape_idx):
	if (
		event is InputEventScreenTouch 
		and event.pressed 
		and is_under_zone
		and (!touch_under_zone or get_is_multi())
	):
		touch_under_zone = true;
		emit_signal("touched_under_zone", self);
		item_touched();

func update_color(color):
	sprite.material = sprite.material.duplicate()
	sprite.material.set_shader_param("color", color)

func set_speed_rotation(speed):
	speed_rotation = speed;
	
func get_touched_color():
	return Color8(255, 255, 255);

func get_value():
	return 0;

func get_combo():
	return 0;
	
func get_is_multi():
	return false;

func enter_zone():
	pass;

func item_touched():
	pass;
