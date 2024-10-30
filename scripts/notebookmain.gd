extends Control
class_name Notebook
var note_on = false
var entry : RichTextLabel
var description : RichTextLabel

func _ready():
	hidenote()
	GlobalEventBus.people_entry.connect(update_people)
	GlobalEventBus.evidence_entry.connect(update_evidence)
	GlobalEventBus.location_entry.connect(update_location)
	if $"../Control/notesec".current_tab == 0:
		entry = $"../Control/notesec/People/GridContainer/POIPanel/POIList"
		description = $"../Control/notesec/People/GridContainer/Description"
		
	elif $"../Control/notesec".current_tab == 1:
		entry = $"../Control/notesec/People/GridContainer/EviPanel/EviList"
		description = $"../Control/notesec/Evidence/GridContainer/Description"
		
	elif $"../Control/notesec".current_tab == 2:
		entry = $"../Control/notesec/People/GridContainer/LocPanel/LocList"
		description = $"../Control/notesec/Location/GridContainer/Description"
	entry.meta_clicked.connect(_on_entry_clicked)
	
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

func create_entry():
	var tween: Tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	var scroll:ScrollBar = entry.get_v_scroll_bar()
	var v: float = scroll.get_value()
	var m: float = scroll.get_max()
	tween.tween_method(scroll.set_value, v, m, 0.55)
	return

func update_people(itemdata):
	entry = $"../Control/notesec/People/GridContainer/POIPanel/POIList"
	description = $"../Control/notesec/People/GridContainer/Description"
	entry.text += "[url=" + itemdata.name + "]" + itemdata.name + "[/url]\n"
	create_entry()
	return

func update_evidence(itemdata):
	entry = $"../Control/notesec/Evidence/GridContainer/EviPanel/EviList"
	description = $"../Control/notesec/Evidence/GridContainer/Description"
	entry.text += "[url=" + itemdata.name + "]" + itemdata.name + "[/url]\n"
	create_entry()
	return

func update_location(place):
	entry = $"../Control/notesec/Evidence/GridContainer/LocPanel/LocList"
	description = $"../Control/notesec/Location/GridContainer/Description"
	entry.text += "[url=" + place.name + "]" + place.name + "[/url]\n"
	create_entry()
	return

func _on_entry_clicked(meta):
	pass
	


