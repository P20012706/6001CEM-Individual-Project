extends Node2D

@onready var transition = $SceneTransition/AnimationPlayer

func _ready():
	pass

func _process(delta):
	pass

func switch_scene(path):
	if path:
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
		var path = "res://scenes/ir.tscn"
		call_deferred("switch_scene",path)
