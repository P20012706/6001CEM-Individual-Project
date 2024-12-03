extends Node2D
@onready var transition = $SceneTransition/AnimationPlayer

func _ready():
	DialogueManager.ending.connect(_the_end)
	$fg1/TalkArea/CollisionShape2D.disabled = true
	$fg1.set_ddindex(1)
	
	
func _process(delta) -> void:
	if check_progress():
		$fg1.visible = true
		$fg1/TalkArea/CollisionShape2D.disabled = false

func _on_ir_exit_body_entered(body):
	if body is Player:
		call_deferred("switch_scene")

func switch_scene():
	get_tree().change_scene_to_file("res://scenes/station.tscn")

func check_progress():
	return Notebookmain.itemdata_map.has("Bloody Clothes")

func _the_end():
	transition.play("fade_to_black")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/capoffice.tscn")
