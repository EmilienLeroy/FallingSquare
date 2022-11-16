extends "res://components/item.gd"

signal loose_life;
var default_color = Color8(201, 201, 201);
var zone_color = Color8(0, 0, 0);
var touch_color = Color8(255, 0, 0);


func _ready():
	update_color(default_color);

func enter_zone():
	update_color(zone_color);

func item_touched():
	update_color(touch_color);
	emit_signal("loose_life");

func get_touched_color():
	return touch_color;
