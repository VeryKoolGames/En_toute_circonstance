extends Node2D

var should_move: bool
var should_play_sound: bool
var spawn_position: Vector2
@onready var timer: Timer = $Timer
@onready var door_slam_sound: AudioStreamPlayer2D = $DoorSlamSound
@export var initial_delay: float
@export var move_towards_left := false
var speed := 10

func _ready() -> void:
	spawn_position = position
	timer.timeout.connect(reset_door_position)
	await get_tree().create_timer(initial_delay).timeout
	timer.start()
	should_move = true
	if move_towards_left:
		speed *= -1


func _process(delta: float) -> void:
	if should_move:
		position.x += delta * speed

func reset_door_position():
	timer.stop()
	if should_play_sound:
		door_slam_sound.play()
	should_move = false
	var tween = create_tween()
	tween.tween_property(self, "position", spawn_position, 0.1)
	await get_tree().create_timer(2).timeout
	should_move = true
	timer.start()


func _on_area_2d_area_entered(area: Area2D) -> void:
	should_play_sound = true


func _on_area_2d_area_exit(area: Area2D) -> void:
	should_play_sound = false
