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

func _ready():
	pass

#Objective


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

#Question Score


func _on_notebook_update_score_e():
	score_e += 1
	score_evi.text = "Evidence Collected: " + str(score_e) + " / 13"
