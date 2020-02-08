extends Node2D

const player_path = "res://player.json"
var npc_path = "janitor.json"
var player_data= { }
var npc_data= { }
var stru = "strength"
# Called when the node enters the scene tree for the first time.
func _ready():
	
	load_player_json()
	load_json("janitor.json")
#	load_json()
#	print(data[stru]["key_words"] )
	
#	return array of similar
func similars(array_counter,array_similar):
	array_similar.resize(player_data["vocabulary"].size() )
	for i in player_data["vocabulary"].size():
		var temp_keyword = player_data["vocabulary"][i]
		if(npc_data.has(temp_keyword)):
			array_similar[array_counter]=temp_keyword
			array_counter+=1
	array_similar.resize(array_counter)
	return array_similar
#	procura keyword
func is_in_dictionary(topic):
	return npc_data[topic]
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
	
