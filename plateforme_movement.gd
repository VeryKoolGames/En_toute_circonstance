extends Node2D

@onready var raycast: RayCast2D = $RayCast2D
@export var speed := 20
@export var move_left: bool
var is_stopped: bool
var spawn_position: Vector2

func _ready() -> void:
	$Area2D.add_to_group("plateforme")
	if move_left:
		raycast.target_position.x = -raycast.target_position.x
		speed *= -1
	spawn_position = position

func _physics_process(delta: float) -> void:
	position.x += delta * speed
	var collider = raycast.get_collider()
	if collider is Node and collider.is_in_group("plateforme") and not is_stopped:
		_switch_direction()
	elif position == spawn_position and not is_stopped:
		_switch_direction()

func _switch_direction():
	raycast.target_position.x = -raycast.target_position.x
	is_stopped = true
	var old_speed: int = speed
	speed = 0
	await get_tree().create_timer(3).timeout
	is_stopped = false
	speed = old_speed
	speed *= -1
