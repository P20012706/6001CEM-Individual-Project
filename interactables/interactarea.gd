extends Area2D

signal first_interaction

func form_interaction():
	emit_signal("first_interaction")
