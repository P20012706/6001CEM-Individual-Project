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
var objectives = ["Objective 1", "Objective 2", "Objective 3"]
var current_objective = 0

func _ready():
	DialogueManager.update_score_q.connect(_on_notebook_update_score_q)
	update_objective()

#Objective


#Timer
func _process(delta) -> void:
	time += delta
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	timer.text = "Time Elapsed: " + "%02d : " % minutes + "%02d" % seconds
	
	if check_objective():
		current_objective += 1
		update_objective()
	

func stop() -> void:
	set_process(false)

func get_time_formatted() -> String:
	return "%02d:%02d" % [minutes, seconds]

func _on_notebook_update_score_e():
	score_e += 1
	score_evi.text = "Evidence Collected: " + str(score_e) + " / 15"

func _on_notebook_update_score_q():
	score_q += 1
	score_que.text = "Correct Questions: " + str(score_q) + " / 10"

func update_objective():
	if current_objective < objectives.size():
		objective.text = "Current Objective: " + objectives[current_objective]
	
func check_objective():
	if current_objective == 0:
		return Notebookmain.itemdata_map.has("Blood Splash")
	elif current_objective == 1:
		#Check
		return Notebookmain.itemdata_map.has("entry_2")
	elif current_objective == 2:
		#check
		return Notebookmain.itemdata_map.has("entry_3")
	return false
	
