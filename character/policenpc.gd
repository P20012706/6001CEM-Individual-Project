extends CharacterBody2D
@export var dialogues: DialogueData

func _ready():
	DialogueManager.add_entry.connect(new_info)
	PersistentDataHandler.set_resource(dialogues)
	PersistentDataHandler.get_value()

func _on_talk_area_start_talking():
	DialogueManager.start_dialogue(dialogues)

func new_info():
	GlobalEventBus.emit_signal("evidence_entry", dialogues.infodata)
	GlobalEventBus.emit_signal("location_entry", dialogues.infodata2)
	GlobalEventBus.emit_signal("location_entry", dialogues.infodata3)
	dialogues.infodata.extracted = true
	print("ENTRY FROM DIALOGUE REGISTERED")

func get_ddindex():
	return dialogues.index
	
func set_ddindex(index: int):
	dialogues.index = index
	PersistentDataHandler.set_value(dialogues)
