extends Node2D

func _on_zone_enter_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Events.on_gravity_zone_entered.emit()


func _on_zone_exit_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Events.on_gravity_zone_exited.emit()
