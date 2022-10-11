extends Node

var Alert = preload("res://components/alert.tscn");

func create_alert(alert_text, alert_type):
	get_tree().call_group("alert", "hide");
	
	var alert = Alert.instance().init(alert_text, alert_type);
	add_child(alert);
	return alert;
