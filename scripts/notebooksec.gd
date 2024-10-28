extends Control
var testfile = "res://test.txt"
var test = FileAccess.open(testfile, FileAccess.READ)
var text1 = test.get_as_text()

func _ready():
	
	$TabContainer/People/GridContainer/VBoxContainer/Button.connect("mouse_entered", _button_hovered)
	$TabContainer/People/GridContainer/VBoxContainer/Button.connect("mouse_exited", _button_exited)

func _button_hovered():
	# Update the left page with the details of the person corresponding to this button
	$TabContainer/People/GridContainer/ScrollContainer/Description/Label.text = "Name:TEST HOVER"

func _button_exited():
	# Optionally clear or reset the details when mouse exits the button
	$TabContainer/People/GridContainer/ScrollContainer/Description/Label.text = text1
	


