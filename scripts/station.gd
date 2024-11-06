extends Node2D

@onready var transition = $SceneTransition/AnimationPlayer

func _ready():
	pass 


func _process(delta):
	pass

func _on_exit_body_entered(body):
	if body is Player:
		transition.play("fade_to_black")
		$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/map.tscn")

func _on_office_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("res://scenes/capoffice.tscn")


func _on_ir_1_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("res://scenes/ir.tscn")


func _on_ir_2_body_entered(body):
	if body is Player:
		get_tree().change_scene_to_file("res://scenes/ir.tscn")
