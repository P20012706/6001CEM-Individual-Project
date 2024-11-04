extends Area2D

signal start_talking

func start_dialogue():
	emit_signal("start_talking")
