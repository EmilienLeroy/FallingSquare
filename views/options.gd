extends Node2D

signal back;

func _ready():
	$Back.connect("button_down", self, "_on_back_down");
	$Languages.connect('item_selected', self, "_on_lang_selected");

	$Languages.add_item('English', 0);
	$Languages.add_item('Français', 1);

	$Languages.select(get_current_lang_id());
	pass

func get_current_lang_id():
	var lang = TranslationServer.get_locale();
	
	if (lang == 'fr'):
		return 1;
	
	return 0;


func _on_lang_selected(id):
	var langs = TranslationServer.get_loaded_locales();
	
	if (!langs[id]):
		return;

	Settings.set_locale(langs[id]);

func _on_back_down():
	emit_signal("back");
