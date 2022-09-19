extends Node2D

signal cancel;
signal send;

var Rank = preload("res://components/rank.tscn");
var Alert = preload("res://components/alert.tscn");
var Highscore = preload("res://modules/highscore.gd");

var score = 0;
var highscore_url = ProjectSettings.get_setting("application/config/highscore");
var highscore = Highscore.new(highscore_url);

func _ready():
	add_child(highscore);

	$Send.connect("button_down", self, "_on_send");
	$Cancel.connect("button_down", self, "_on_cancel");
	$Value.text = str(score);
	
	var result = yield(highscore.get_scores(4), 'completed');
	
	if (result.err != OK):
		# TODO: display an error
		return;
	
	add_scores(result.data);

func _on_send():
	var name = $Name.text;
	
	if (!name):
		# TODO: display an error
		return;

	var result = yield(highscore.post_score(name, score), 'completed');
	
	if (result.err != OK):
		# TODO: display an error
		return;
	
	emit_signal("send");
	pass

func _on_cancel():
	emit_signal("cancel", score);
	
func add_scores(ranks):
	if (!ranks):
		# TODO: display error
		return;
	
	for rank in ranks:
		var rankItem = Rank.instance();
		rankItem.set_rank(rank);
		$Scores.add_child(rankItem);

func create_alert(alert_text, alert_type):
	get_tree().call_group("alert", "hide");
	
	var alert = Alert.instance().init(alert_text, alert_type);
	add_child(alert);
	return alert;
