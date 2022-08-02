extends CanvasLayer

var combo = 0 setget set_combo, get_combo;


func set_combo(c): 
	if (c > 0 && combo == 0):
		$AnimationPlayer.play("display");
		
	if (c == 0 && combo > 0):
		$AnimationPlayer.play("hide");

	combo = c;
	$Panel/HBoxContainer/Value.text = 'x' + str(combo);

func get_combo():
	return combo;
