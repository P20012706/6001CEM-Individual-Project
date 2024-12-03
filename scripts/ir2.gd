extends Node2D
@onready var transition = $SceneTransition/AnimationPlayer

func _ready():
	DialogueManager.ending.connect(_the_end)
	$fg2.set_ddindex(2)
	$fg2/TalkArea/CollisionShape2D.disabled = true
	
func _process(delta) -> void:
	if check_progress():
		$fg2.visible = true
		$fg2/TalkArea/CollisionShape2D.disabled = false


func _on_ir2_exit(body: Node2D) -> void:
	if body is Player:
		call_deferred("switch_scene")

func switch_scene():
	get_tree().change_scene_to_file("res://scenes/station.tscn")

func check_progress():
	return Notebookmain.itemdata_map.has("Bloody Tire Iron")

func _the_end():
	transition.play("fade_to_black")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/capoffice.tscn")
