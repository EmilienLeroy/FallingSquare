extends MarginContainer

func set_rank(rank):
	$HBoxContainer/Rank.text = str(rank.rank) + ".";
	$HBoxContainer/Name.text = str(rank.name);
	$HBoxContainer/Value.text = str(rank.value);

