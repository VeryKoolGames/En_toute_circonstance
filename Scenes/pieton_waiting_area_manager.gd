extends Area2D

@onready var timer: Timer = $Timer
@onready var crowd_noise: AudioStreamPlayer2D = $CrowNoiseSound

func _ready() -> void:
	timer.timeout.connect(on_waiting_complete)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		crowd_noise.playing = true
		timer.start()

func on_waiting_complete():
	Events.on_pietion_waited.emit()
	await get_tree().create_timer(0.5).timeout
	crowd_noise.playing = false

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		timer.stop()
		crowd_noise.playing = false
