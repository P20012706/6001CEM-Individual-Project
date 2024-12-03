extends Node2D
@export var dialoguedata: DialogueData

func _ready():
	if dialoguedata:
		PersistentDataHandler.set_resource(dialoguedata)
		PersistentDataHandler.get_value()
		apply_persistent_data()

func apply_persistent_data():
	var persistent_data = SaveManager.get_persistent_data(dialoguedata)
	if persistent_data.has("dialogue_index"):
		dialoguedata.index = persistent_data["dialogue_index"]
		print("Dialogue index restored to:", dialoguedata.index)

func _on_interact_area_first_interaction():
	if dialoguedata != null:
		var new_info_found := false

		for infodata in dialoguedata.infodata_array:
			if infodata != null and not infodata.extracted:
				GlobalEventBus.emit_signal("evidence_entry", dialoguedata.infodata_array[0])
				infodata.extracted = true
				new_info_found = true

		if new_info_found or dialoguedata.index < dialoguedata.dialogue_array.size():
			DialogueManager.start_dialogue(dialoguedata)
		
		save_item_state()

			
func get_infodata():
	return dialoguedata.infodata_array[0]


func set_infodata():
	if dialoguedata != null and dialoguedata.infodata_array.size() > 0:
		dialoguedata.infodata_array[0].extracted = true
		GlobalEventBus.emit_signal("evidence_entry", dialoguedata.infodata_array[0])
		save_item_state()
		
func save_item_state():
	if dialoguedata:
		var save = {
			"dialogue_index": dialoguedata.index
		}
		SaveManager.add_persistent_data(dialoguedata, save)
