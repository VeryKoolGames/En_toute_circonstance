extends Node2D

var should_move: bool
@onready var timer: Timer = $Timer
var spawn_position: Vector2
@export var initial_delay: float

func _ready() -> void:
	spawn_position = position
	timer.timeout.connect(reset_door_position)
	await get_tree().create_timer(initial_delay).timeout
	timer.start()
	should_move = true


func _process(delta: float) -> void:
	if should_move:
		position.x += delta * 10

func reset_door_position():
	print(should_move)
	timer.stop()
	should_move = false
	print(should_move)
	var tween = create_tween()
	tween.tween_property(self, "position", spawn_position, 0.1)
	await get_tree().create_timer(2).timeout
	should_move = true
	print(should_move)
	timer.start()
