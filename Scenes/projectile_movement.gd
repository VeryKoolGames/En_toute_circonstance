extends Node2D

@onready var timer: Timer = $Timer
var spawn_pos: Vector2

func _ready() -> void:
	spawn_pos = position
	timer.timeout.connect(reset_position)
	timer.start()

func reset_position():
	position = spawn_pos

func _process(delta: float) -> void:
	position.x -= delta * 30
