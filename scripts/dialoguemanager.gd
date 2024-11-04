extends Node

var mid_dialogue = false
var dd: DialogueData
signal progress_dialogue
signal add_entry

func start_dialogue(dialogue):
	if mid_dialogue:
		return
	
	var dialogue_branch
	if dialogue.dialogue_array.size() > 0 and mid_dialogue == false:
		mid_dialogue = true
		
		dialogue_branch = dialogue.dialogue_array[dialogue.progression]
		if dialogue_branch is DialogicTimeline:
			Dialogic.signal_event.connect(on_dialogic_signal)
			Dialogic.start(dialogue_branch)
			await Dialogic.timeline_ended
			Dialogic.signal_event.disconnect(on_dialogic_signal)
		else:
			push_warning("This is not a valid DialogicTimeline.")

func on_dialogic_signal(arguement: String):
	match arguement:
		"Complete":
			mid_dialogue = false
			print("Dialogue Complete, but no Progress.")

		"Progress":
			mid_dialogue = false
			emit_signal("progress_dialogue")
		
		"Information":
			emit_signal("add_entry")

func progression(dialogue):
	if dialogue.progression < dialogue.dialogue_array.size() - 1:
		dialogue.progression += 1
		print("Progressing to next")
