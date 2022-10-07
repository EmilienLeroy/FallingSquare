extends MarginContainer



func set_rank(rank):
	var new_style = StyleBoxFlat.new();
	new_style.set_bg_color(get_rank_color(rank.rank));
	new_style.set_corner_radius_all(15);
	$Panel.set('custom_styles/panel', new_style);
	$Panel/HBoxContainer/Rank.text = str(rank.rank) + ".";
	$Panel/HBoxContainer/Name.text = str(rank.name);
	$Panel/HBoxContainer/Value.text = str(rank.value);

func get_rank_color(rank = null):
	if (rank == 1):
		return Color8(239, 172, 0);

	if (rank == 2):
		return Color8(155, 183, 204);
	
	if (rank == 3):
		return Color8(199, 108, 34);
	
	
	return Color8(0, 117, 255); 
