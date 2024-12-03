extends CanvasLayer

@onready var main : NinePatchRect = $Control/notemain
@onready var section : TabContainer = $Control/notesec
@onready var entry_ppl : RichTextLabel = $Control/notesec/People/GridContainer/POIPanel/POIList
@onready var description_ppl : RichTextLabel = $Control/notesec/People/GridContainer/Description
@onready var entry_evi : RichTextLabel = $Control/notesec/Evidence/GridContainer/EviPanel/EviList
@onready var description_evi : RichTextLabel = $Control/notesec/Evidence/GridContainer/Description
@onready var entry_loc : RichTextLabel = $Control/notesec/Location/GridContainer/LocPanel/LocList
@onready var description_loc : RichTextLabel = $Control/notesec/Location/GridContainer/Description


var entry
var description
var note_on = false
var itemdata_map = {}
signal update_score_e


func _ready():
	hidenote()
	section.tab_selected.connect(on_tab_selected)
	GlobalEventBus.people_entry.connect(update_people)
	GlobalEventBus.evidence_entry.connect(update_evidence)
	GlobalEventBus.location_entry.connect(update_location)

func _process(_delta):
	if Input.is_action_just_pressed("notebook"):
		if note_on:
			hidenote()
		else:
			open()

func open():
	self.visible = true
	note_on = true
	section.visible = false
	main.visible = true
	

func hidenote():
	visible = false
	note_on = false
	

func _on_pplbtn_pressed():
	section.current_tab = 0
	main.visible = false
	section.visible = true

func _on_evibtn_pressed():
	section.current_tab = 1
	main.visible = false
	section.visible = true

func _on_locbtn_pressed():
	section.current_tab = 2
	main.visible = false
	section.visible = true

func on_tab_selected(index):
	match index:
		0:
			entry = entry_ppl
			description = description_ppl
		1:
			entry = entry_evi
			description = description_evi
		2:
			entry = entry_loc
			description = description_loc
	
	if not entry.meta_clicked.is_connected(_on_entry_clicked):
		entry.meta_clicked.connect(_on_entry_clicked)

func update_people(itemdata):
	if itemdata is Array:
		for info in itemdata:
			if not itemdata_map.has(info.name) and info.category == "People":
				itemdata_map[info.name] = info
				entry_ppl.append_text("[url=" + info.name + "]" + info.name + "[/url]\n")
	else:
		if not itemdata_map.has(itemdata.name) and itemdata.category == "People":
			itemdata_map[itemdata.name] = itemdata
			entry_ppl.append_text("[url=" + itemdata.name + "]" + itemdata.name + "[/url]\n")
	return

func update_evidence(itemdata):
	if itemdata is Array:
		for info in itemdata:
			if not itemdata_map.has(info.name) and info.category == "Evidence":
				itemdata_map[info.name] = info
				entry_evi.append_text("[url=" + info.name + "]" + info.name + "[/url]\n")
	
	else:
		if not itemdata_map.has(itemdata.name) and itemdata.category == "Evidence":
			itemdata_map[itemdata.name] = itemdata
			entry_evi.append_text("[url=" + itemdata.name + "]" + itemdata.name + "[/url]\n")
			emit_signal("update_score_e")
	return

func update_location(itemdata):
	if itemdata is Array:
		for info in itemdata:
			if not itemdata_map.has(info.name) and info.category == "Location":
				itemdata_map[info.name] = info
				entry_loc.append_text("[url=" + info.name + "]" + info.name + "[/url]\n")
	else:
		if not itemdata_map.has(itemdata.name) and itemdata.category == "Location":
			itemdata_map[itemdata.name] = itemdata
			entry_loc.append_text("[url=" + itemdata.name + "]" + itemdata.name + "[/url]\n")
	return

func _on_entry_clicked(meta):
	var itemdata = itemdata_map.get(meta, null)
	if itemdata:
		description.text = "DESCRIPTION:\n" + itemdata.description + \
		"\n\nImage:\n [center] [img=" + \
		str(itemdata.length*4) + "x" + str(itemdata.height*4) +"]" + itemdata.path \
		 + "[/img] [/center]"
	
func got_entry(entry: Array) -> bool:
	for i in entry:
		if not itemdata_map.has(i):
			return false
	return true
