extends Node2D
@export var infodata: InfoData

func _ready():
	$spark.play("default")

func _on_interact_area_first_interaction():
	if infodata.extracted == false:
		#Add A Dialogic Timeline
		GlobalEventBus.emit_signal("evidence_entry", infodata)
		infodata.extracted = true
		
	else:
		#Add another Dialogic Timeline(Self-Monologue) that says you checked this, Nothing New.
		print("You have already interacted.")

func get_infodata():
	return infodata
