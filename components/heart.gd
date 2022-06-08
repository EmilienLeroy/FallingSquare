extends MarginContainer

onready var sprite = $Sprite;
export var alive = true setget set_alive, get_alive
var alive_color = Color8(255, 0, 0);
var dead_color = Color8(0, 0, 0);

func set_alive(a):
	var color =  alive_color if a else dead_color;
	update_color(color);
	alive = a;
	
func get_alive():
	return alive;

func _ready():
	update_color(alive_color);
	pass

func update_color(color):
	sprite.material = sprite.material.duplicate()
	sprite.material.set_shader_param("color", color)
