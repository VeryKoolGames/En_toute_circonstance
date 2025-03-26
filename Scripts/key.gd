extends Node2D

@export var door: Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		hide()
		var tween = create_tween()
		var end_pos: Vector2 = door.position
		end_pos.y += 20
		tween.tween_property(door, "position", end_pos, 2)
		await tween.finished
		door.queue_free()
		queue_free()
