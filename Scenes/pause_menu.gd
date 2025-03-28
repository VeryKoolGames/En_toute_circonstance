extends Control

@onready var resume_button: Button = $ResumeButton
@onready var main_menu_button: Button = $MainMenuButton
@onready var hover_sound: AudioStreamPlayer2D = $HoverSound

var is_paused: bool = false
var has_game_ended: bool = false

func _ready():
	Events.on_ending_reached.connect(on_game_ended)
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	resume_button.mouse_entered.connect(_on_end_screen_button_entered.bind(resume_button))
	resume_button.mouse_exited.connect(_on_end_screen_button_exited.bind(resume_button))
	main_menu_button.mouse_exited.connect(_on_end_screen_button_exited.bind(main_menu_button))
	main_menu_button.mouse_entered.connect(_on_end_screen_button_entered.bind(main_menu_button))

func on_game_ended(_test: bool):
	has_game_ended = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and not has_game_ended:
		toggle_pause()

func toggle_pause():
	is_paused = !is_paused
	if is_paused:
		Events.on_pause_menu_activated.emit()
	get_tree().paused = is_paused
	visible = is_paused
	if is_paused:
		get_viewport().set_input_as_handled()

func _on_mainmenu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")

func _on_resume_pressed() -> void:
	toggle_pause()

func _on_end_screen_button_entered(button: Button) -> void:
	hover_sound.playing = true
	button.modulate = Color("#ffa300")
	button.get_child(0).modulate = Color("#ffa300")

func _on_end_screen_button_exited(button: Button) -> void:
	button.modulate = Color("#ffffff")
	button.get_child(0).modulate = Color("#ffffff")
