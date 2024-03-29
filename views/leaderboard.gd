extends Node2D

signal back;

var Rank = preload("res://components/rank.tscn");
var Alert = preload("res://components/alert.tscn");
var Highscore = preload("res://modules/highscore.gd");

var highscore_url = ProjectSettings.get_setting("application/config/highscore");
var highscore = Highscore.new(highscore_url);

func _ready():
	add_child(highscore);
	
	$Buttons/Global.connect("button_down", self, "display_global");
	$Buttons/Me.connect("button_down", self, "display_me");
	$Back.connect("button_down", self, "_on_back_down");
	
	set_global();

func set_global():
	var result = yield(highscore.get_scores(50), 'completed');
	
	if (result.err != OK):
		Utils.create_alert("SAVE_ERROR_LOADING", "error");
		return;
	
	add_scores(result.data);
	pass
	
func set_me():
	var result = yield(highscore.get_my_scores(50), 'completed');
	
	if (result.err != OK):
		Utils.create_alert("SAVE_ERROR_LOADING", "error");
		return;
	
	add_scores(result.data);
	pass

func add_scores(ranks):
	if (!ranks):
		Utils.create_alert("SAVE_ERROR_LOADING", "error");
		return;
	
	for rank in ranks:
		var rankItem = Rank.instance();
		rankItem.set_rank(rank);
		$Scroll/Scores.add_child(rankItem);

func display_global():
	delete_scores();
	set_global();
	return;

func display_me():
	delete_scores();
	set_me();
	return;

func delete_scores():
	for n in $Scroll/Scores.get_children():
		$Scroll/Scores.remove_child(n)
		n.queue_free()

func _on_back_down():
	emit_signal("back");
