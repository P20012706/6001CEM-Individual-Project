extends Area2D

class_name CorpseArea
signal first_interaction

func form_interaction():
	emit_signal("first_interaction")
	pass
