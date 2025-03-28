extends RigidBody2D

func _ready() -> void:
	$Area2D.add_to_group("rock")
