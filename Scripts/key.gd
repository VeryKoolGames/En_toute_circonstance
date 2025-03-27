extends Node2D

@export var door: Node2D
@onready var pick_up_sound: AudioStreamPlayer2D = $KeyPickUpSound
@onready var door_opening_sound: AudioStreamPlayer2D = $DoorOpeningSound

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		pick_up_sound.playing = true
		hide()
		await get_tree().create_timer(0.2).timeout
		var tween = create_tween()
		var end_pos: Vector2 = door.position
		end_pos.y += 20
		door_opening_sound.playing = true
		tween.set_parallel()
		tween.tween_property(door, "position", end_pos, 2)
		tween.tween_property(door_opening_sound, "volume_db", -20, 1.2)
		await tween.finished
		door.queue_free()
		queue_free()
