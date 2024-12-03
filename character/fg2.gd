extends CharacterBody2D
@export var dialogues: DialogueData

func _ready():
	if not DialogueManager.add_entry.is_connected(self.new_info):
		DialogueManager.add_entry.connect(new_info)
	if dialogues:
		PersistentDataHandler.set_resource(dialogues)
		PersistentDataHandler.get_value()
		apply_persistent_data()

func apply_persistent_data():
	var persistent_data = SaveManager.get_persistent_data(dialogues)
	if persistent_data.has("dialogue_index"):
		dialogues.index = persistent_data["dialogue_index"]
		print("Dialogue index restored to:", dialogues.index)

func _on_talk_area_start_talking():
	DialogueManager.start_dialogue(dialogues)
	

func _process(delta) -> void:
	$AnimatedSprite2D.play("talk")


var entry_queue: Array = []

func new_info():
	if dialogues.infodata_array:
		for infodata in dialogues.infodata_array:
			if infodata != null and not infodata.extracted:
				entry_queue.append(infodata)
				infodata.extracted = true
		
		process_entry_queue()
	
	var data_to_save = {
		"extracted": true,  # Example of data to save
		"dialogue_index": dialogues.dialogue_array.find(dialogues.dialogue_array[dialogues.index])
	}
	dialogues.index = 1
	SaveManager.add_persistent_data(dialogues, data_to_save)
	
func process_entry_queue():
	if entry_queue.size() > 0:
		var next_entry = entry_queue.pop_front()
		match next_entry.category:
					"Evidence":
						GlobalEventBus.emit_signal("evidence_entry", next_entry)
					"People":
						GlobalEventBus.emit_signal("people_entry", next_entry)
					"Location":
						GlobalEventBus.emit_signal("location_entry", next_entry)

		PersistentDataHandler.set_value(dialogues)

				
func get_ddindex():
	return dialogues.index
	
func set_ddindex(index: int):
	dialogues.index = index
	PersistentDataHandler.set_value(dialogues)
