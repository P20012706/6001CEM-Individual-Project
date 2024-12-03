extends Node2D

@onready var transition = $SceneTransition/AnimationPlayer

func switch_scene(path):
	get_tree().change_scene_to_file(path)

func _on_exit(body):
	if body is Player:
		var path = "res://scenes/map.tscn"
		transition.play("fade_to_black")
		await get_tree().create_timer(0.7).timeout
		call_deferred("switch_scene", path)

func _on_entrance(body):
	if body is Player:
		var path = "res://scenes/vhome(in).tscn"
		transition.play("fade_to_black")
		await get_tree().create_timer(0.7).timeout
		call_deferred("switch_scene", path)
