extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_zone_enter_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Events.on_gravity_zone_entered.emit()


func _on_zone_exit_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		Events.on_gravity_zone_exited.emit()
