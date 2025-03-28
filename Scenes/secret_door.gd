extends Node2D

var spawn_position: Vector2
var should_move := false
var has_already_played: bool
@onready var door_slam_sound: AudioStreamPlayer2D = $DoorSlamSound

func _ready() -> void:
	spawn_position = position
	position.x += 13

func _process(delta: float) -> void:
	if should_move:
		position.x += delta * 30
	if position.x >= 14:
		queue_free()

func _on_trigger_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("player") and not has_already_played:
		has_already_played = true
		door_slam_sound.play()
		var tween = create_tween()
		tween.tween_property(self, "position", spawn_position, 0.1)
		await get_tree().create_timer(2).timeout
		should_move = true
