extends Node2D
@export var infodata: InfoData
@export var infodata2: InfoData

func _on_corpse_area_first_interaction():
	if infodata.extracted == false and infodata2.extracted == false:
		Dialogic.start("corpse")
		GlobalEventBus.emit_signal("people_entry", infodata)
		GlobalEventBus.emit_signal("evidence_entry", infodata2)
		infodata.extracted = true
		infodata2.extracted = true
	
	else:
		#Add another Dialogic Timeline(Self-Monologue) that says you checked this
		print("You have already interacted.")

func get_infodata():
	return infodata
	return infodata2

func set_infodata():
	infodata.extracted = true
	infodata2.extracted = true
	GlobalEventBus.emit_signal("people_entry", infodata)
	GlobalEventBus.emit_signal("evidence_entry", infodata2)
	
