extends Control
class_name Notebook
var note_on = false


func _ready():
	hidenote()

func _process(_delta):
	if Input.is_action_just_pressed("notebook"):
		if note_on:
			hidenote()
		else:
			open()
			
func open():
	self.visible = true
	note_on = true
	$notesec.visible = false
	$notemain.visible = true
	
	

func hidenote():
	visible = false
	note_on = false
	
	
func _on_pplbtn_pressed():
	$notesec.current_tab = 0
	$notemain.visible = false
	$notesec.visible = true

func _on_evibtn_pressed():
	$notesec.current_tab = 1
	$notemain.visible = false
	$notesec.visible = true

func _on_locbtn_pressed():
	$notesec.current_tab = 2
	$notemain.visible = false
	$notesec.visible = true
