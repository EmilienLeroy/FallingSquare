extends "res://components/square.gd";

var current_color = 0;
var colors = [
	Color8(51, 255, 84),
	Color8(0, 222, 138),
	Color8(0, 185, 164),
	Color8(0, 147, 162),
	Color8(0, 108, 134),
	Color8(47, 72, 88),
];

func get_is_multi():
	return true;
	
func item_touched():
	.item_touched();
	update_touched_color();


func update_touched_color():
	current_color = current_color + 1;
	
	if (current_color >= colors.size()):
		current_color = 0;

func get_touched_color():
	return colors[current_color];
