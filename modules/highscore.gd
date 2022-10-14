extends Node2D

var url = ''
var http = HTTPRequest.new();

func _init(server_url):
	if (!server_url):
		push_error('Missing highscore url !');

	url = server_url;
	add_child(http);

func get_header():
	return [
		"Content-Type: application/json",
		"Cookie: " + read_cookies()
	];

func get_scores(limit = 0, skip = 0, base_url = url):
	var get = base_url + '?limit=' + str(limit) + '&skip=' + str(skip);
	var err = http.request(get, get_header());
	var result = yield(http, "request_completed");
	var data = JSON.parse(result[3].get_string_from_utf8()).result;
	
	return { 
		'data': data, 
		'err': err 
	};

func get_my_scores(limit = 0, skip = 0):
	return get_scores(limit, skip, url + '/me');

func post_score(name, score):
	var query = JSON.print({
		"name": name,
		"value": score,
	});
	
	var err = http.request(
		url, 
		get_header(), 
		true, 
		HTTPClient.METHOD_POST, 
		query
	);
	
	var result = yield(http, "request_completed");
	var data = JSON.parse(result[3].get_string_from_utf8()).result;
	var cookies = get_cookie_session(result[2]); 
	
	if (cookies):
		save_cookies(cookies);
	
	return { 
		'data': data, 
		'err': err 
	};

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

