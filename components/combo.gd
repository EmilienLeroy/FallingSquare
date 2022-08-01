extends CanvasLayer

var combo = 0 setget set_combo, get_combo;


func set_combo(c): 
	combo = c;
	$Panel/HBoxContainer/Value.text = 'x' + str(combo);

func get_combo():
	return combo;
