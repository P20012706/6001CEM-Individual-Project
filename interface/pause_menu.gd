extends CanvasLayer

@onready var savebtn: Button = $VBoxContainer/savebtn
@onready var loadbtn: Button = $VBoxContainer/loadbtn
@onready var exitbtn: Button = $VBoxContainer/exitbtn

var is_paused : bool

func _ready() -> void:
	hide_pause_menu()
	savebtn.pressed.connect(_on_save_pressed)
	loadbtn.pressed.connect(_on_load_pressed)
	exitbtn.pressed.connect(_on_exit_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	get_tree().paused = true
	visible = true
	is_paused = true

func hide_pause_menu() -> void:
	get_tree().paused = false
	visible = false
	is_paused = false

func _on_save_pressed() -> void:
	SaveManager.save_game()

func _on_load_pressed() -> void:
	SaveManager.load_game()

func _on_exit_pressed() -> void:
	get_tree().quit()
