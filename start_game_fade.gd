extends Control

@onready var fade_overlay: ColorRect = $ColorRect

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(fade_overlay, "modulate:a", 0, 2)
	tween.tween_callback(queue_free)
