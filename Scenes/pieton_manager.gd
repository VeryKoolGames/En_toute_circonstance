extends Node2D

@onready var timer: Timer = $Timer
var spawn_position: Vector2

func _ready() -> void:
	spawn_position = position
	#timer.timeout.connect(_reset_pieton)

func _physics_process(delta: float) -> void:
	position.y += delta * 20

func _reset_pieton():
	position = spawn_position
	timer.start()
