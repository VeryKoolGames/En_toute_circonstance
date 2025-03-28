extends Node2D

@onready var snoring_sound: AudioStreamPlayer2D = $Sounds/SnoringSound
@onready var phone_sound: AudioStreamPlayer2D = $Sounds/PhoneSound
@onready var speech_sound: AudioStreamPlayer2D = $Sounds/SpeechSound
@onready var wake_up_sound: AudioStreamPlayer2D = $Sounds/WakeUpSound
@onready var angry_sound: AudioStreamPlayer2D = $Sounds/AngryDadSound
@onready var music: AudioStreamPlayer2D = $Sounds/MenuMusic
@onready var hover_sound: AudioStreamPlayer2D = $Sounds/HoverSound
@onready var fade_overlay: ColorRect = $StartMenuUI/ColorRect
@onready var phone_text: Label = $StartMenuUI/Label
@onready var arrow1: TextureRect = $StartMenuUI/commencer/arrow_1
@onready var arrow2: TextureRect = $StartMenuUI/quitter/arrow_2

func on_start_button_up():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(fade_overlay, "color:a", 1.0, 2)
	tween.tween_property(music, "volume_db", -80, 2)
	await tween.finished
	snoring_sound.playing = true
	await get_tree().create_timer(8).timeout
	snoring_sound.playing = false
	phone_sound.playing = true
	await get_tree().create_timer(5).timeout
	phone_sound.playing = false
	wake_up_sound.playing = true
	await get_tree().create_timer(4).timeout
	await play_fade_out("221d53", 3)
	speech_sound.playing = true
	await write_text()
	speech_sound.playing = false
	await get_tree().create_timer(3).timeout
	fade_overlay.z_index = 5
	angry_sound.playing = true
	await play_fade_out("ffffff", 3.65)
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func play_fade_out(color: String, time_to_wait: float):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(fade_overlay, "color", Color(color), time_to_wait)
	await tween.finished

func write_text():
	var random_text: String = PhoneTexts.get_random_text()
	var buffer := ""
	for letter in random_text:
		buffer += letter
		phone_text.text = buffer
		await get_tree().create_timer(0.05).timeout


func _on_commencer_mouse_entered() -> void:
	hover_sound.playing = true
	arrow1.modulate = Color("#ffa300")


func _on_quitter_mouse_entered() -> void:
	hover_sound.playing = true
	arrow2.modulate = Color("#ffa300")


func _on_commencer_mouse_exited() -> void:
	arrow1.modulate = Color("#ffffff")


func _on_quitter_mouse_exited() -> void:
	arrow2.modulate = Color("#ffffff")


func _on_quitter_button_up() -> void:
	get_tree().quit()
