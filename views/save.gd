extends Node2D

signal cancel;

var score = 0;
var highscore_url = ProjectSettings.get_setting("application/config/highscore");

func _ready():
	$Send.connect("button_down", self, "_on_send");
	$Cancel.connect("button_down", self, "_on_cancel");
	$GET.connect("request_completed", self, "_on_get_scores");
	
	$Value.text = str(score);
	
	if (!highscore_url):
		# TODO: display an error
		return;
	
	var error = $GET.request(highscore_url);

	if (error != OK):
		# TODO: display an error
		return;

func _on_send():
	# TODO: send score to highscore 
	pass

func _on_cancel():
	emit_signal("cancel", score);
	
func _on_get_scores(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	var ranks = json.result;
	
	# TODO: Display scores
