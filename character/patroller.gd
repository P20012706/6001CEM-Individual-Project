extends CharacterBody2D
@export var dialogues: DialogueData

func _ready():
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
	$AnimatedSprite2D.play("default")
	
func process_entry_queue():
		PersistentDataHandler.set_value(dialogues)

func get_ddindex():
	return dialogues.index
	
func set_ddindex(index: int):
	dialogues.index = index
	PersistentDataHandler.set_value(dialogues)
