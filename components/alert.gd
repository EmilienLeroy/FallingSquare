extends Panel

var text = '';
var type = 'info';

func init(alert_text, alert_type = 'info'):
	text = alert_text;
	type = alert_type;
	
	return self;

func _ready():
	var new_style = StyleBoxFlat.new();
	
	new_style.set_bg_color(get_alert_color());
	new_style.set_corner_radius_all(5);
	
	set('custom_styles/panel', new_style);
	$Label.text = text;
	$AnimationPlayer.play("show");
	pass

func hide():
	$AnimationPlayer.play("hide");
	yield($AnimationPlayer, "animation_finished");
	queue_free();

func get_alert_color():
	if (type == 'info'):
		return Color8(0, 0, 255);

	if (type == 'success'):
		return Color8(0, 255, 0);
	
	if (type == 'error'):
		return Color8(255, 0, 0);
