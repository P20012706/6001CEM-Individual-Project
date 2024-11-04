extends Node2D
@export var infodata: InfoData
@export var infodata2: InfoData

func _on_corpse_area_first_interaction():
	if infodata.extracted == false:
		Dialogic.start("test")
		GlobalEventBus.emit_signal("people_entry", infodata)
		GlobalEventBus.emit_signal("evidence_entry", infodata2)
		infodata.extracted = true
	
	else:
		#Add another Dialogic Timeline(Self-Monologue) that says you checked this, Nothing New.
		print("You have already interacted.")
