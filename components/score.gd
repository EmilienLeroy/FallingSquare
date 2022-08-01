extends CanvasLayer

var score = 0 setget set_score, get_score;

func set_score(s): 
	score = s;
	$HBoxContainer/Value.text = str(score);

func get_score():
	return score;
