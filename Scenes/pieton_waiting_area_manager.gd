extends Area2D

@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(on_waiting_complete)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		timer.start()

func on_waiting_complete():
	Events.on_pietion_waited.emit()

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		timer.stop()
