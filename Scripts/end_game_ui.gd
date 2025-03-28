extends Control

@onready var fade_overlay: ColorRect = $ColorRect
@onready var end_text: Label = $EndTextLabel
@onready var letter_ui: Control = $Control
@onready var total_amount_text: Label = $Control/Label
@onready var restart_button: Button = $Control/RestartButton
@onready var main_menu_button: Button = $Control/MainMenuButton
@onready var hover_sound: AudioStreamPlayer2D = $HoverSound
@onready var applause_sound: AudioStreamPlayer2D = $ApplauseSound

func _ready() -> void:
	Events.on_ending_reached.connect(start_ending_sequence)

func start_ending_sequence():
	total_amount_text.text = "$ " + str(PlayerInfo.get_damaged_amount())
	var tween: Tween = create_tween()
	applause_sound.playing = true
	tween.tween_property(fade_overlay, "color:a", 1, 2)
	tween.tween_property(end_text, "modulate:a", 1, 2)
	tween.tween_property(applause_sound, "volume_db", -50, 2)
	tween.tween_interval(3)
	tween.tween_property(end_text, "modulate:a", 0, 2)
	tween.tween_interval(2)
	tween.tween_property(letter_ui, "modulate:a", 1, 2)
	tween.tween_callback(_activate_ui)
	restart_button.mouse_entered.connect(_on_end_screen_button_entered.bind(restart_button))
	restart_button.mouse_exited.connect(_on_end_screen_button_exited.bind(restart_button))
	main_menu_button.mouse_exited.connect(_on_end_screen_button_exited.bind(main_menu_button))
	main_menu_button.mouse_entered.connect(_on_end_screen_button_entered.bind(main_menu_button))

func _activate_ui() -> void:
	letter_ui.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_restart_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_main_menu_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")

func _on_end_screen_button_entered(button: Button) -> void:
	hover_sound.playing = true
	button.modulate = Color("#ffa300")
	button.get_child(0).modulate = Color("#ffa300")

func _on_end_screen_button_exited(button: Button) -> void:
	button.modulate = Color("#ffffff")
	button.get_child(0).modulate = Color("#ffffff")
