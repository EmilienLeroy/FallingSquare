extends Node2D

signal restart;
signal home;
signal save;

var score = 0;
var stats = {};
var save = false;

func _ready():
	$Home.connect("button_down", self, "_on_home");
	$Restart.connect("button_up", self, "_on_restart");
	$Save.connect("button_down", self, "_on_save");
	$Stats.set_stats(stats);
	$Value.text = str(score);
	
	if (save):
		save_stats(stats);

	pass

func _on_home():
	emit_signal("home");
	
func _on_restart():
	emit_signal("restart");

func _on_save():
	emit_signal("save", score, stats);

func save_stats(s):
	var new_stats = {};
	var file = File.new();
	
	file.open("user://stats.save", File.READ);
	var prev = str2var(file.get_as_text());
	file.close();

	if (prev):
		new_stats.square = s.square + prev.square;
		new_stats.bomb = s.bomb + prev.bomb;
		new_stats.restore = s.restore + prev.restore;
		new_stats.reset = s.reset + prev.reset;
		new_stats.game = prev.game + 1;
	else:
		new_stats.square = s.square;
		new_stats.bomb = s.bomb;
		new_stats.restore = s.restore;
		new_stats.reset = s.reset;
		new_stats.game = 1;
	
	file.open("user://stats.save", File.WRITE);
	file.store_string(var2str(new_stats));
	file.close();
