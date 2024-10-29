extends Node2D
@export var infodata: InfoData
@export var infodata2: InfoData

signal update_Notebook
var interacted = false

func _on_car_area_first_interaction():
	if not interacted:
		print("KEY ITEM 2!")
		#Update Notebook (For Later)
		interacted = true
	else:	
		print("Discovered Item 2.")
