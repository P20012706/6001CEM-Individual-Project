extends Node2D

@onready var transition = $SceneTransition/AnimationPlayer

func _ready():
	DialogueManager.fade.connect(_fade_to_station)

func _on_exit_body_entered(body):
	if body is Player:
		call_deferred("switch_scene")

func switch_scene():
	transition.play("fade_to_black")
	await get_tree().create_timer(0.7).timeout
	get_tree().change_scene_to_file("res://scenes/map.tscn")

func _fade_to_station():
	transition.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	transition.play("fade_from_black")
	$fg2.visible = false
	$fg2/TalkArea/CollisionShape2D.disabled = true
	$fg2/CollisionShape2D.disabled = true
