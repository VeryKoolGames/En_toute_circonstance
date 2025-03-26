extends Node2D

var spawn_position: Vector2
@export var move_speed: int = 60
@onready var respawn_timer: Timer = $Timer

func _ready() -> void:
	spawn_position = position
	respawn_timer.start(3)
	respawn_timer.timeout.connect(on_respawn)

func _physics_process(delta: float) -> void:
	position.x += move_speed * delta

func on_respawn():
	position = spawn_position
	respawn_timer.start(3)
