extends Node2D

signal cancel;
signal send;

var Rank = preload("res://components/rank.tscn");
var Highscore = preload("res://modules/highscore.gd");

var score = 0;
var stats = {};
var highscore_url = ProjectSettings.get_setting("application/config/highscore");
var highscore = Highscore.new(highscore_url);

func _ready():
	add_child(highscore);

	$Send.connect("button_down", self, "_on_send");
	$Cancel.connect("button_down", self, "_on_cancel");
	$Value.text = str(score);
	
	var result = yield(highscore.get_scores(4), 'completed');
	
	if (result.err != OK):
		Utils.create_alert("SAVE_ERROR_LOADING", "error");
		return;
	
	add_scores(result.data);

func _on_send():
	var name = $Name.text;
	
	if (!name):
		Utils.create_alert("SAVE_ERROR_NAME", "error");
		return;

	var result = yield(highscore.post_score(name, score), 'completed');
	
	if (result.err != OK or result.data == null):
		Utils.create_alert("SAVE_ERROR_SEND", "error");
		return;
	
	emit_signal("send", result.data);
	pass

func _on_cancel():
	emit_signal("cancel", score, stats);
	
func add_scores(ranks):
	if (!ranks):
		Utils.create_alert("SAVE_ERROR_LOADING", "error");
		return;
	
	for rank in ranks:
		var rankItem = Rank.instance();
		rankItem.set_rank(rank);
		$Scores.add_child(rankItem);
