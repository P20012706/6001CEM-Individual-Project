extends Node2D

@onready var transition = $SceneTransition/AnimationPlayer
@onready var cam = $player/Camera2D2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_body_entered(body):
	if body is Player:
		transition.play("fade_to_black")
		$Timer.start()
		


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/map.tscn")
