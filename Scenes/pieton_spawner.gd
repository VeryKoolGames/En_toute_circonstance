extends Node2D

@onready var timer: Timer = $Timer
@export var parent: Node
@export var pieton_scene: PackedScene
var should_spawn: bool

func _ready() -> void:
	timer.timeout.connect(spawn_pieton)
	_start_timer()
	Events.on_pietion_waited.connect(_stop_pieton_spawn)

func _stop_pieton_spawn():
	should_spawn = false

func spawn_pieton():
	var pieton = pieton_scene.instantiate()
	pieton.global_position = global_position
	parent.add_child(pieton)
	_start_timer()

func _start_timer():
	timer.wait_time = randf_range(1, 4)
	timer.start()
