extends Node


func _on_zone_enter_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Events.on_ending_reached.emit()
