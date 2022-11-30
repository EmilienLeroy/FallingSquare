extends Node2D

signal back;
var stats;

func _ready():
	$Back.connect("button_down", self, "_on_back_down");
	stats = get_stats();
	
	if (stats):
		$Stats.set_stats(stats);
		
	if (stats and stats.game):
		$Games.text = str(stats.game);
	
	pass 

func _on_back_down():
	emit_signal("back");

func get_stats():
	var file = File.new();
	
	file.open("user://stats.save", File.READ);
	var stats = str2var(file.get_as_text());
	file.close();
	
	return stats;
