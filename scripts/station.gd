extends Node2D

@onready var transition = $SceneTransition/AnimationPlayer

	
func switch_scene(path):
	if path:
		transition.play("fade_to_black")
		await get_tree().create_timer(0.7).timeout
		get_tree().change_scene_to_file(path)

func _on_exit(body):
	if body is Player:
		var path = "res://scenes/map.tscn"
		call_deferred("switch_scene",path)

func _on_office_exit(body):
	if body is Player:
		var path = "res://scenes/capoffice.tscn"
		call_deferred("switch_scene",path)

func _on_ir_exit(body):
	if body is Player:
		var path = "res://scenes/ir1.tscn"
		call_deferred("switch_scene",path)

func _on_ir_2_exit(body):
	if body is Player:
		var path = "res://scenes/ir2.tscn"
		call_deferred("switch_scene",path)
