extends Node

const SAVEPATH =  "user://"

signal game_saved
signal game_loaded

var current_save: Dictionary = {
	scene_path = "",
	extracted_item = [],
	npc_index = {},
	persistence = {}
}

func save_game():
	update_savedata()
	save_scene()
	var savefile := FileAccess.open(SAVEPATH + "savefile.json",FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	savefile.store_line(save_json)
	print("Game Successfully Saved!")
	pass

func load_game():
	var savefile = FileAccess.open(SAVEPATH + "savefile.json", FileAccess.READ)
	var json := JSON.new()
	json.parse(savefile.get_line())
	current_save = json.get_data() as Dictionary
	
	# Reapply persistent data
	for resource_id in current_save.persistence.keys():
		var data = current_save.persistence[resource_id]
		var resource = ResourceLoader.load(resource_id)  # Load the resource
		if resource is DialogueData:
			if data.has("dialogue_index"):
				resource.index = data["dialogue_index"]
				
	
	# Update scene objects
	var items = get_tree().get_nodes_in_group("evidence")
	for i in items:
		if i.has_method("set_infodata"):
			i.set_infodata()

	var npc = get_tree().get_nodes_in_group("npc")
	for n in npc:
		if n.has_method("set_ddindex"):
			n.set_ddindex(n.dialogues.index)
	
	get_tree().change_scene_to_file(current_save.scene_path)
	print("Loaded from Latest Save!")


	
func update_savedata():
	var items = get_tree().get_nodes_in_group("evidence")
	for i in items:
		if i.has_method("get_infodata"):
			var infodata = i.get_infodata()
			if infodata.extracted and not current_save.extracted_item.has(i.name):
				current_save.extracted_item.append(i.name)
	
	# Save NPC dialogues via persistence
	var npc = get_tree().get_nodes_in_group("npc")
	for n in npc:
		if n.has_method("get_ddindex"):
			var data_to_save = {
				"dialogue_index": n.get_ddindex()
			}
			add_persistent_data(n.dialogues, data_to_save)


func add_persistent_data(resource: Resource, data: Dictionary) -> void:
	if resource != null:
		var resource_id = resource.get_path()
		current_save.persistence[resource_id] = data
		


func check_persistent_data(resource:Resource):
	var resource_id = resource.get_path()
	return current_save.persistence.has(resource_id)

func get_persistent_data(resource:Resource) -> Dictionary:
	var resource_id = resource.get_path()  
	if current_save.persistence.has(resource_id):
		return current_save.persistence[resource_id]
	else:
		return {}

func save_scene():
	current_save.scene_path = get_tree().current_scene.scene_file_path
	
