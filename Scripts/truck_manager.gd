extends Node2D

var spawn_position: Vector2
@export var move_speed: int = 60
@onready var respawn_timer: Timer = $Timer
@onready var honk_sound: AudioStreamPlayer2D = $HonkSound
@onready var ambient_sound: AudioStreamPlayer2D = $AmbientSound

func _ready() -> void:
	spawn_position = position
	respawn_timer.start(3)
	respawn_timer.timeout.connect(on_respawn)

func _physics_process(delta: float) -> void:
	position.x += move_speed * delta

func on_respawn():
	position = spawn_position
	respawn_timer.start(3)


func _on_honk_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		honk_sound.pitch_scale = randf_range(0.9, 1.1)
		honk_sound.playing = true


func _on_zone_enter_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		ambient_sound.playing = true

func _on_zone_enter_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		ambient_sound.playing = false
