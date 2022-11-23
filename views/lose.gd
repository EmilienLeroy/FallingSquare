extends Node2D

signal restart;
signal home;
signal save;

var score = 0;
var stats = {};

func _ready():
	$Home.connect("button_down", self, "_on_home");
	$Restart.connect("button_up", self, "_on_restart");
	$Save.connect("button_down", self, "_on_save");
	$Value.text = str(score);
	
	save_stats(stats);
	pass

func _on_home():
	emit_signal("home");
	
func _on_restart():
	emit_signal("restart");

func _on_save():
	emit_signal("save", score);

func save_stats(s):
	var file = File.new()
	
	file.open("user://stats.save", File.READ);
	var prev_stats = str2var(file.get_as_text());
	file.close();

	if (prev_stats):
		s.square += prev_stats.square;
		s.bomb += prev_stats.bomb;
		s.restore += prev_stats.restore;
		s.reset += prev_stats.reset;
	
	file.open("user://stats.save", File.WRITE);
	file.store_string(var2str(s));
	file.close();
