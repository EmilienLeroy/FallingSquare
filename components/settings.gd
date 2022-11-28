extends Node

signal settings_updated;

var settings = {
	'locale': null,
	'musics': true,
	'sfx': true,
};

func _ready():
	var user_settings = get_settings();
	
	if (!user_settings):
		return;
	
	if (user_settings.has('locale')):
		settings.locale = user_settings.locale;
	
	if (user_settings.has('musics')):
		settings.musics = user_settings.musics;
		
	if (user_settings.has('sfx')):
		settings.sfx = user_settings.sfx;
	
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
	
	update_settings();
	
func set_musics(musics):
	settings.musics = musics;
	
	update_settings();
	
func set_sfx(sfx):
	settings.sfx = sfx;
	
	update_settings();
	
func init_settings(user_settings):
	if (!user_settings.locale):
		return;
	
	TranslationServer.set_locale(user_settings.locale);

func update_settings():
	save_settings();
	emit_signal("settings_updated", settings);
