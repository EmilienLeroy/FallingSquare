extends Node2D


func set_stats(stats):
	$SquareScore/Label.text = str(stats.square);
	$RestoreScore/Label.text = str(stats.restore);
	$ResetScore/Label.text = str(stats.reset);
	$BombScore/Label.text = str(stats.bomb);
