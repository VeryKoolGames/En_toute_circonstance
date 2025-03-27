extends Node2D

@export var scale_min: float = 1
@export var scale_max: float = 1.4
@export var scale_duration: float = 1.0

func _ready() -> void:
	await get_tree().create_timer(randf_range(0, 0.5))
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "scale", Vector2(scale_max, scale_max), scale_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector2(scale_min, scale_min), scale_duration).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
