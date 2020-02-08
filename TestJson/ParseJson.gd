extends Node2D

var path = "res://janitor.json"
var data= { }

# Called when the node enters the scene tree for the first time.
func _ready():
	load_json()
	
	print(data["strength"]["key_words"] )
	print(get_message(data["strength"]) )
	print(get_event(data["you strong"]) )
#	procura keyword
func is_in_keyword(topic,keyword):
	var key_words = topic.get("key_words")
	for i in key_words.size():
		if(key_words[i]==keyword):
			return true
	return false
#Get values from data

func get_message(topic):
	
	return topic.get("message") 
	
func get_event(topic):
	
	return int(topic.get("event") )
	
func save_json():
	var file
	
	file = File.new()
	
	file.open(path, File.WRITE)
	
	file.store_line(to_json(data))
	
	file.close()

func load_json():
	
	var file = File.new()
	
	if not file.file_exists(path):
		print("didn't find json file")
		return
		
	file.open(path, file.READ)
	
	var text = file.get_as_text()
#	data recebe json
	data = parse_json(text)
	
	file.close()