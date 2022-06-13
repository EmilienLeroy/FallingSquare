extends MarginContainer;

var Heart = preload("res://components/heart.tscn");

export var hearts = 3;

func _ready():
	update_hearts(hearts);
	pass
	
func update_hearts(new_hearts):
	hearts = new_hearts;
	
	for n in $Hearts.get_children():
		$Hearts.remove_child(n)
		n.queue_free()
	
	for heart in hearts:
		$Hearts.add_child(create_heart(heart))	

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
	enable_heart(hearts);
	hearts = hearts + 1;

func remove_heart():
	hearts = hearts - 1;

	if (hearts < 0):
		return;
	
	disable_heart(hearts);
