extends Node2D
@export var infodata: InfoData
@export var infodata2: InfoData
signal update_Notebook
var interacted = false

func _on_interact():
	if interacted == false:
		print("First Interaction!")
		#Update Notebook
		interacted = true
	else:	
		print("You have interacted before.")
		
