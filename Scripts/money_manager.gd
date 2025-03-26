extends Node

@export var value_label: Label
@export var res_total_value: FloatValue
var total_value: int

func _ready() -> void:
	Events.on_player_died.connect(_decrease_value)
	total_value = int(res_total_value.value)
	value_label.text = "$ " + str(total_value)

func _decrease_value() -> void:
	var value_loss = randi_range(int(res_total_value.value) / 8, int(res_total_value.value) / 9)
	total_value -= value_loss
	print(total_value)
	print(value_loss)
	value_label.text = "$ " + str(total_value)
