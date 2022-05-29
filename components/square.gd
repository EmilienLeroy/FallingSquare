extends "res://components/item.gd"

signal increase_score;
signal loose_life;

onready var notifier = $VisibilityNotifier2D;

func _ready():
	notifier.connect("screen_exited", self, "_on_exit_screen");

func item_touched():
	emit_signal("increase_score");
	update_color(Color8(51, 255, 84));
	pass;
	
func enter_zone():
	update_color(Color8(0, 117, 255));

func _on_exit_screen():
	emit_signal("loose_life");
	pass;
