extends Node2D

@onready var timer: Timer = $Timer
var spawn_position: Vector2

func _ready() -> void:
	spawn_position = global_position
	if randi() % 2 == 1:
		$Sprite2D.flip_h = true

func _physics_process(delta: float) -> void:
	position.y += delta * 20

func randomize_x_position():
	global_position.x += randf_range(position.x - 0.5, position.x + 0.5)

func _reset_pieton():
	position = spawn_position
	randomize_x_position()
	timer.start()
