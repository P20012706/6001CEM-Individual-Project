extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func switch_scene(path):
	get_tree().change_scene_to_file(path)


func _on_exit(body):
	if body is Player:
		var path = "res://scenes/map.tscn"
		call_deferred("switch_scene", path)

func _on_entrance(body):
	if body is Player:
		var path = "res://scenes/vhome(in).tscn"
		call_deferred("switch_scene", path)
