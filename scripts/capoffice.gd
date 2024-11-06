extends Node2D


func _on_office_exit_area_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("res://scenes/station.tscn")
