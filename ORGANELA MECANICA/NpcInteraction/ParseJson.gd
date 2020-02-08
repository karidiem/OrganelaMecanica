extends Node2D

const player_path = "res://player.json"
var npc_path = ""
var player_data= { }
var npc_data= { }
var stru = "strength"
# Called when the node enters the scene tree for the first time.
func _ready():
	load_player_json()
#	load_json()
	print(player_data["vocabulary"].size())
#	print(data[stru]["key_words"] )
	
	
	
#	procura keyword
func is_in_keyword(topic):
	for i in player_data["vocabulary"].size():
		var temp_keyword = player_data["vocabulary"][i]
		for j in npc_data.size():
			if(temp_keyword==topic):
				return true
	return false
#Get values from data

func get_message(topic):
	return npc_data[topic].get("message") 
	
func get_event(topic):
	
	return int(topic.get("event") )
	
func save_json():
	var file
	
	file = File.new()
	
	file.open(player_path, File.WRITE)
	
	file.store_line(to_json(player_data))
	
	file.close()

func load_json(path):
	
	var file = File.new()
	
	if not file.file_exists(path):
		print("didn't find json file")
		return
		
	file.open(path, file.READ)
	
	var text = file.get_as_text()
#	data recebe json
	npc_data = parse_json(text)
	
	file.close()
	

func load_player_json():
	
	var file = File.new()
	
	if not file.file_exists(player_path):
		print("didn't find json file")
		return
		
	file.open(player_path, file.READ)
	
	var text = file.get_as_text()
#	data recebe json
	player_data = parse_json(text)
	
	file.close()
	
