extends AudioStreamPlayer2D

@onready var music_opener: AudioStreamPlayer2D = $MainMusicOpener

func _ready() -> void:
	Events.on_first_clicked.connect(_switch_to_main_music)
	Events.on_gravity_zone_entered.connect(_slow_down_music)
	Events.on_gravity_zone_exited.connect(_reset_music_pitch)


func _slow_down_music() -> void:
	var tween = create_tween()
	tween.tween_property(self, "pitch_scale", 0.6, 1.5)
	

func _reset_music_pitch() -> void:
	var tween = create_tween()
	tween.tween_property(self, "pitch_scale", 1, 1.5)

func _switch_to_main_music():
	music_opener.playing = false
	playing = true
