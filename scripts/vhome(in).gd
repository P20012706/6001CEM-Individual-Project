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
	get_tree().change_scene_to_file("res://scenes/vhome(out).tscn")
	
func _fade_to_station():
	transition.play("fade_to_black")
	await get_tree().create_timer(0.5).timeout
	transition.play("fade_from_black")
	$fg1.visible = false
	$fg1/TalkArea/CollisionShape2D.disabled = true
	$fg1/CollisionShape2D.disabled = true
