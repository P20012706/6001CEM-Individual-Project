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

func _on_corpse_area_first_interaction():
	if dialoguedata != null:
		var new_info_found := false

		for infodata in dialoguedata.infodata_array:
			if infodata != null and not infodata.extracted:
				GlobalEventBus.emit_signal("people_entry", dialoguedata.infodata_array[0])
				GlobalEventBus.emit_signal("evidence_entry", dialoguedata.infodata_array[1])
				infodata.extracted = true
				new_info_found = true

		if new_info_found:
			DialogueManager.start_dialogue(dialoguedata)
		else:
			DialogueManager.start_dialogue(dialoguedata)

func get_infodata():
	return dialoguedata.infodata_array[0]
	return dialoguedata.infodata_array[1]

func set_infodata():
	dialoguedata.infodata_array[0].extracted = true
	dialoguedata.infodata_array[1].extracted = true
	GlobalEventBus.emit_signal("people_entry", dialoguedata.infodata_array[0])
	GlobalEventBus.emit_signal("evidence_entry", dialoguedata.infodata_array[1])
	
