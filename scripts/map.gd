extends Control

@onready var location: Array = [$station, $crimescene, $vhome, $casino]
@onready var locks: Array = [$crimescene/lock, $vhome/lock, $casino/lock]
@onready var transition = $SceneTransition/AnimationPlayer
var current_position: int = 0

func _ready():
	$PlayerIcon.global_position = location[current_position].global_position

func _input(event):
	if event.is_action_pressed("left") and current_position > 0:
		current_position -=1
		$PlayerIcon.global_position = location[current_position].global_position
		check_lock()
	
	elif event.is_action_pressed("right") and current_position < 3:
		current_position +=1
		$PlayerIcon.global_position = location[current_position].global_position
		check_lock()
		
	elif event.is_action_pressed("dialogic_default_action"):
		transition.play("fade_to_black")
		$Timer.start()
		

#Progress Lock
var requirement = {
	"crimescene" : ["Crime Alley"],
	"vhome" : ["Victim's Home"],
	"casino" : ["Grand Casino"]
}

func check_lock():
	pass


func _on_timer_timeout():
	if location[current_position] == $station:
		get_tree().change_scene_to_file("res://scenes/station.tscn")
				
	elif location[current_position] == $crimescene:
		get_tree().change_scene_to_file("res://scenes/crimescene.tscn")
				
	elif location[current_position] == $vhome:
		get_tree().change_scene_to_file("res://scenes/vhome(out).tscn")
				
	elif location[current_position] == $casino:
		get_tree().change_scene_to_file("res://scenes/casino.tscn")
