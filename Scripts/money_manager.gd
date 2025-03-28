extends Node

@export var value_label: Label

func _ready() -> void:
	Events.on_player_died.connect(_decrease_value)
	value_label.text = "$ " + str(PlayerInfo.car_value)

func _decrease_value() -> void:
	var value_loss = randi_range(PlayerInfo.car_value / 8, PlayerInfo.car_value / 9)
	PlayerInfo.car_value -= value_loss
	value_label.text = "$ " + str(PlayerInfo.car_value)
