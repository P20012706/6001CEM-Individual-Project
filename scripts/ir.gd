extends Node2D

func _on_ir_exit_body_entered(body):
	if body is Player:
		call_deferred("switch_scene")

func switch_scene():
	get_tree().change_scene_to_file("res://scenes/station.tscn")
