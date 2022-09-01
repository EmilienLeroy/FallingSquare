extends Node2D

signal cancel;
signal send;

var Rank = preload("res://components/rank.tscn");

var score = 0;
var highscore_url = ProjectSettings.get_setting("application/config/highscore");

func _ready():
	$Send.connect("button_down", self, "_on_send");
	$Cancel.connect("button_down", self, "_on_cancel");
	$GET.connect("request_completed", self, "_on_get_scores");
	
	$Value.text = str(score);
	
	if (!highscore_url):
		# TODO: display an error
		return;
	
	var error = $GET.request(highscore_url + "?limit=4");

	if (error != OK):
		# TODO: display an error
		return;

func _on_send():
	var name = $Name.text;
	
	if (!name):
		# TODO: display an error
		return;

	var query = JSON.print({
		"name": name,
		"value": score,
	});
	
	var headers = [
		"Content-Type: application/json",
		"Cookie: " + read_cookies()
	];
	
	var err = $POST.request(highscore_url, headers, true, HTTPClient.METHOD_POST, query);
	var result = yield($POST, "request_completed");
	var json = JSON.parse(result[3].get_string_from_utf8()).result;
	var cookies = get_cookie_session(result[2]); 
	
	if (cookies):
		save_cookies(cookies);

	if (err or !json):
		# TODO: display error
		return;

	emit_signal("send");
	pass

func get_cookie_session(headers):
	var session = '';
	
	for h in headers:
		if h.to_lower().begins_with("set-cookie"):
			session = h.split(":", true, 1)[1].strip_edges();
			
	return session;

func save_cookies(c):
	var file = File.new();

	file.open("user://data.save", File.WRITE);
	file.store_string(var2str({ "cookies": c }));
	file.close();
	
func read_cookies():
	var file = File.new()
	
	file.open("user://data.save", File.READ);
	var data = str2var(file.get_as_text());
	file.close();
	
	if (data):
		return data["cookies"];
	
	return ''; 


func _on_cancel():
	emit_signal("cancel", score);
	
func _on_get_scores(result, response_code, headers, body):
	var ranks = JSON.parse(body.get_string_from_utf8()).result;
	
	if (!ranks):
		# TODO: display error
		return;
	
	for rank in ranks:
		var rankItem = Rank.instance();
		rankItem.set_rank(rank);
		$Scores.add_child(rankItem);
