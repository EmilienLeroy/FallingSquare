extends "res://components/item.gd"

signal increase_score;
signal loose_life;

onready var notifier = $VisibilityNotifier2D;

var item_name = 'square';
var touched_color setget , get_touched_color;
 
func _ready():
	notifier.connect("screen_exited", self, "_on_exit_screen");

func get_touched_color():
	return Color8(51, 255, 84);

func get_value():
	return 1;

func get_combo():
	return 1;

func item_touched():
	emit_signal("increase_score");
	update_color(get_touched_color());
	pass;
	
func enter_zone():
	update_color(Color8(0, 117, 255));

func _on_exit_screen():
	if (touch_under_zone):
		return;

	emit_signal("loose_life");
	pass;
