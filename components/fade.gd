extends CanvasLayer

func _ready():
	pass

func fade_in():
	$Animation.play("fade_in");
	
func fade_out():
	$Animation.play("fade_out");
