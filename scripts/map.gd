extends Control

@onready var transition = $SceneTransition/AnimationPlayer
var locations = ["stationarea", "scenearea", "vhomearea", "casinoarea"]
@onready var ray : RayCast2D = PlayerManager.player.get_node("RayCast2D")
var player : Player
var requirement = {
	"crimescene" : ["Crime Alley"],
	"vhome" : ["Victim's Home"],
	"casino" : ["Grand Casino"]
}

var location_to_scene = {
	"stationarea": "res://scenes/station.tscn",
	"scenearea": "res://scenes/crimescene.tscn",  
	"vhomearea": "res://scenes/vhome.tscn",  
	"casinoarea": "res://scenes/casino.tscn"  
}

func _ready():
	pass

func _on_timer_timeout():
	var location_name = ray.get_collider().name
	# Check if the location is valid and either no requirements or requirements met
	if location_name in locations:
		if location_name == "stationarea" or got_entry(requirement.get(location_name, [])):
			var scene_path = location_to_scene.get(location_name, "")
			if scene_path != "":
				get_tree().change_scene_to_file(scene_path)

func _on_stationarea_location_entered(location_name):
	if location_name == "stationarea" or got_entry(requirement.get(location_name, [])):
		transition.play("fade_to_black")
		$Timer.start()


func _on_scenearea_location_entered(location_name):
	if location_name == "scenearea" or got_entry(requirement.get(location_name, [])):
		transition.play("fade_to_black")
		$Timer.start()


func _on_vhomearea_location_entered(location_name):
	if location_name == "vhomearea" or got_entry(requirement.get(location_name, [])):
		transition.play("fade_to_black")
		$Timer.start()


func _on_casinoarea_location_entered(location_name):
	if location_name == "casinoarea" or got_entry(requirement.get(location_name, [])):
		transition.play("fade_to_black")
		$Timer.start()

# Checks if the required entries exist in the notebook system
func got_entry(entry: Array) -> bool:
	for i in entry:
		if not Notebookmain.itemdata_map.has(i):
			return false
	return true
