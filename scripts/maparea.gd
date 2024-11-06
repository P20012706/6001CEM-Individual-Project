extends Area2D

signal location_entered(location_name)

func travel():
	emit_signal("location_entered", self.name)
