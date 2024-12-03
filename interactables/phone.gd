extends Node2D
@export var dialoguedata: DialogueData

func _on_interact_area_first_interaction():
	if dialoguedata != null:
		var new_info_found := false

		for infodata in dialoguedata.infodata_array:
			if infodata != null and not infodata.extracted:
				GlobalEventBus.emit_signal("location_entry", dialoguedata.infodata_array[0])
				infodata.extracted = true
				new_info_found = true

		if new_info_found:
			DialogueManager.start_dialogue(dialoguedata)
		else:
			DialogueManager.start_dialogue(dialoguedata)
			
func get_infodata():
	return dialoguedata.infodata_array[0]


func set_infodata():
	dialoguedata.infodata_array[0].extracted = true
	GlobalEventBus.emit_signal("location_entry", dialoguedata.infodata_array[0])
