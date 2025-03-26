extends Node2D

@onready var spawn_timer: Timer = $Timer
@export var rock_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.timeout.connect(_spawn_rock)
	spawn_timer.start()
	
func _spawn_rock():
	var new_scene: Node = rock_scene.instantiate()
	add_child(new_scene)
	spawn_timer.start()
