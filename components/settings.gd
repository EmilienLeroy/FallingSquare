extends Node

var settings = {
	'locale': null,
};

func _ready():
	var user_settings = get_settings();
	
	if (!user_settings):
		return;
	
	settings = user_settings;
	init_settings(settings);

	pass

func get_settings():
	var file = File.new()
	
	file.open("user://settings.save", File.READ);
	var user_settings = str2var(file.get_as_text());
	file.close();
	
	return user_settings;
	
func save_settings():
	var file = File.new();
	
	file.open("user://settings.save", File.WRITE);
	file.store_string(var2str(settings));
	file.close();

func set_locale(locale):
	TranslationServer.set_locale(locale);
	settings.locale = locale;
	save_settings();
	
func init_settings(user_settings):
	if (!user_settings.locale):
		return;
	
	TranslationServer.set_locale(user_settings.locale);
