extends Node

signal data_loaded
var value : bool = false
var resource_reference : Resource = null

func _ready()-> void:
	if resource_reference:
		get_value()

func set_value(resource: Resource) -> void:
	if resource != null:
		SaveManager.add_persistent_data(resource, get_persistent_data())

func get_value() -> void:
	if resource_reference != null:
		value = SaveManager.check_persistent_data(resource_reference)
		emit_signal("data_loaded")

func set_resource(resource: Resource) -> void:
	resource_reference = resource

func _get_resource() -> Resource:
	return resource_reference

func get_persistent_data() -> Dictionary:
	if resource_reference != null:
		return SaveManager.get_persistent_data(resource_reference)
	else:
		return {}
