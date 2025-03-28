extends Node

var car_value := 45000
var original_car_value: int

func _enter_tree() -> void:
	original_car_value = car_value

func get_damaged_amount():
	return original_car_value - car_value
