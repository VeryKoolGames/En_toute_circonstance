extends Node2D

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Events.on_player_died.emit()
