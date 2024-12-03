extends Node2D

@onready var transition = $SceneTransition/AnimationPlayer

func _on_exit_body_entered(body):
	if body is Player:
		call_deferred("switch_scene")

func switch_scene():
	transition.play("fade_to_black")
	await get_tree().create_timer(0.7).timeout
	get_tree().change_scene_to_file("res://scenes/map.tscn")
