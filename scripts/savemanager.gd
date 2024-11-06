extends Node

const SAVEPATH =  "user://"

signal game_saved
signal game_loaded

var current_save: Dictionary = {
	scene_path = "",
	extracted_item = [],
	npc_index = {},
	player_data = {}
}

func save_game():
	update_savedata()
	update_player()
	var savefile := FileAccess.open(SAVEPATH + "savefile.json",FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	savefile.store_line(save_json)
	print("Game Successfully Saved!")
	pass

func load_game():
	var savefile = FileAccess.open(SAVEPATH + "savefile.json", FileAccess.READ)
	var json := JSON.new()
	json.parse(savefile.get_line())
	var save_dict : Dictionary = json.get_data() as Dictionary
	current_save = save_dict
	
	
	var items = get_tree().get_nodes_in_group("evidence")
	for i in items:
		if i.has_method("set_infodata"):
			i.set_infodata()
	
	var npc = get_tree().get_nodes_in_group("npc")
	for n in npc:
		if n.has_method("set_ddindex") and n.name in current_save.npc_index:
			var saved_index = current_save.npc_index[n.name]
			n.set_ddindex(saved_index)
	
	var player = get_node("player")
	Player.global_position.x = current_save.player_data["pos_x"]
	Player.global_position.y = current_save.player_data["pos_y"]
	get_tree().change_scene_to_file(current_save.scene_path)
	print("Loaded from Latest Save!")
	
func update_savedata():
	var items = get_tree().get_nodes_in_group("evidence")
	for i in items:
		if i.has_method("get_infodata"):
			var infodata = i.get_infodata()
			if infodata.extracted:
				if not current_save.extracted_item.has(i.name):
					current_save.extracted_item.append(i.name)
	
	var npc = get_tree().get_nodes_in_group("npc")
	for n in npc:
		if n.has_method("get_ddindex"):
			var dialoguedata = n.get_ddindex()
			current_save.npc_index[n.name] = dialoguedata
	
func update_player():
	var player: Player = get_node("player")
	current_save.player_data["pos_x"] = Player.global_position.x
	current_save.player_data["pos_y"] = Player.global_position.y
	current_save.scene_path = get_tree().current_scene.scene_file_path
	print(current_save.scene_path)
