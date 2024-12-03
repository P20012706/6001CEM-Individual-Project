extends Node2D
@export var dialoguedata: DialogueData

func _on_interact_area_first_interaction():
	DialogueManager.start_dialogue(dialoguedata)
