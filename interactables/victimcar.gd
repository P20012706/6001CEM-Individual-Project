extends Node2D
@export var infodata: InfoData


var interacted = false

func _on_car_area_first_interaction():
	if not interacted:
		print(infodata.description)
		GlobalEventBus.emit_signal("evidence_entry", infodata)
		interacted = true
	else:	
		print("Discovered Item 2.")
