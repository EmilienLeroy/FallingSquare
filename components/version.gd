extends PanelContainer


func _ready():
	$Label.text = "v" + ProjectSettings.get_setting("application/config/version");
	pass 

