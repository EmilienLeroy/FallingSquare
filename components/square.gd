extends "res://components/item.gd"

signal increase_score;
signal loose_life;

onready var notifier = $VisibilityNotifier2D;

func _ready():
	notifier.connect("screen_exited", self, "_on_exit_screen");

func get_value():
	return 1;

func item_touched():
	emit_signal("increase_score");
	update_color(Color8(51, 255, 84));
	pass;
	
func enter_zone():
	update_color(Color8(0, 117, 255));

func _on_exit_screen():
	if (touch_under_zone):
		return;

	emit_signal("loose_life");
	pass;
