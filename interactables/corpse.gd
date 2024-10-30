extends Node2D
@export var infodata: InfoData
@export var infodata2: InfoData

var interacted = false



func _on_corpse_area_first_interaction():
	if not interacted:
		print("KEY ITEM!")
		Dialogic.start("test")
		GlobalEventBus.emit_signal("people_entry", infodata)
		GlobalEventBus.emit_signal("evidence_entry", infodata2)
		interacted = true
	else:	
		print("Discovered Item 1.")
