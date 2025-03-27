extends Control

@onready var snoring_sound: AudioStreamPlayer2D = $Sounds/SnoringSound
@onready var fade_overlay: ColorRect = $StartMenuUI/ColorRect

func on_start_button_up():
	print("Clicking")
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(fade_overlay, "modulate:a", 1.0, 0.5)
	await tween.finished
	snoring_sound.playing = true
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func on_exit_button_up():
	get_tree().quit()
