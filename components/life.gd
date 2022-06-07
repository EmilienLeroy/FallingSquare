extends MarginContainer;

var Heart = preload("res://components/heart.tscn");

export var hearts = 3;

func _ready():
	for heart in hearts:
		$Hearts.add_child(create_heart(heart))
		
	pass

func create_heart(id):
	var heart = Heart.instance();
	heart.set_name('heart_' + String(id));
	return heart;

func enable_heart(id):
	var heart = $Hearts.get_node('heart_' + String(id));
	
	if (!heart):
		return;
		
	heart.alive = true;

func disable_heart(id):
	var heart = $Hearts.get_node('heart_' + String(id));
	
	if (!heart):
		return;
		
	heart.alive = false;
	
func add_heart():
	hearts = hearts + 1;
	enable_heart(hearts);

func remove_heart():
	hearts = hearts - 1;
	
	if (hearts <= 0):
		return;
	
	disable_heart(hearts);
