extends CharacterBody2D
@export var dialogues: DialogueData

func _ready():
	DialogueManager.add_entry.connect(new_info)

func _on_talk_area_start_talking():
	DialogueManager.start_dialogue(dialogues)
	await DialogueManager.progress_dialogue
	DialogueManager.progression(dialogues)

func new_info():
	GlobalEventBus.emit_signal("evidence_entry", dialogues.infodata)
	print("IT FUCKING WORKED")
