extends Control
@onready var objective = $CurrentObjective
@onready var timer = $TimeElapsed
@onready var score_evi = $EvidencedCollected
@onready var score_que = $CorrectQuestions
var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var score_e: int = 0
var score_q: int = 0
var objectives = ["", "Report To Captain", "Meet Roy", 
 				"Identify the victim", "Question the Hobo", "Call Operator with Phone",
 				"Check Around the Victim's House", "Ask the Neighbor for Info", 
 				"Search The House", "Question the Man in Blue", "Call Operator with Phone",
 				"Find the Manager", "Question Nathan","Investigate the Orange Sedan",
 				"Question Martin in I.Room 1", "Question Nathan in I.Room 2", "Select One to Press Charges", "Report To Captain Again"]
var current_objective = 0

func _ready():
	DialogueManager.update_score_q.connect(_on_notebook_update_score_q)
	DialogueManager.update_o.connect(update_objective)



#Timer
func _process(delta) -> void:
	time += delta
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	timer.text = "Time Elapsed: " + "%02d : " % minutes + "%02d" % seconds
	
func stop() -> void:
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d" % [minutes, seconds]

func _on_notebook_update_score_e():
	score_e += 1
	score_evi.text = "Evidence Collected: " + str(score_e) + " / 16"

func _on_notebook_update_score_q():
	score_q += 1
	score_que.text = "Correct Questions: " + str(score_q) + " / 16"

func update_objective():
	if current_objective < objectives.size():
		current_objective += 1
		objective.text = "Current Objective: " + objectives[current_objective]
