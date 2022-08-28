extends Node2D

signal cancel;

var score = 0;
var highscore_url = ProjectSettings.get_setting("application/config/highscore");

func _ready():
	$Send.connect("button_down", self, "_on_send");
	$Cancel.connect("button_down", self, "_on_cancel");
	$Value.text = str(score);
	
	if (!highscore_url):
		# TODO: display an error
		return;
	
	# TODO: get score from highscore

func _on_send():
	# TODO: send score to highscore 
	pass

func _on_cancel():
	emit_signal("cancel", score);
