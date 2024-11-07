extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_body_entered(body):
	if body is Player:
		call_deferred("switch_scene")

func switch_scene():
	get_tree().change_scene_to_file("res://scenes/map.tscn")
