extends Node2D

@onready var transition = $SceneTransition/AnimationPlayer

func switch_scene(path):
	if path:
		transition.play("fade_to_black")
		await get_tree().create_timer(0.7).timeout
		get_tree().change_scene_to_file(path)

func _on_start_pressed() -> void:
	var path = "res://scenes/station.tscn"
	call_deferred("switch_scene",path)

func _on_exit_pressed() -> void:
	get_tree().quit()
