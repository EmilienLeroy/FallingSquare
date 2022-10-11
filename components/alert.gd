extends CanvasLayer

var text = '';
var type = 'info';

func init(alert_text, alert_type = 'info'):
	text = alert_text;
	type = alert_type;
	
	return self;

func _ready():
	var new_style = StyleBoxFlat.new();
	
	new_style.set_bg_color(get_alert_color());
	new_style.set_corner_radius_all(15);
	
	$Panel.set('custom_styles/panel', new_style);
	
	$Panel.connect("gui_input", self, "_on_input");
	$Panel/Label.text = text;
	$Panel/AnimationPlayer.play("show");
	pass

func hide():
	$Panel/AnimationPlayer.play("hide");
	yield($Panel/AnimationPlayer, "animation_finished");
	queue_free();
	
func _on_input(e):
	hide();

func get_alert_color():
	if (type == 'info'):
		return Color8(0, 117, 255);

	if (type == 'success'):
		return Color8(71, 208, 93);
	
	if (type == 'error'):
		return Color8(232, 87, 87);
