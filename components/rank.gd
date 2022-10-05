extends MarginContainer

func set_rank(rank):
	$Panel/HBoxContainer/Rank.text = str(rank.rank) + ".";
	$Panel/HBoxContainer/Name.text = str(rank.name);
	$Panel/HBoxContainer/Value.text = str(rank.value);

