extends Node2D

@onready var timer: Timer = $Timer
var spawn_position: Vector2
var train_speed: int = 20
var base_train_speed: int

func _ready() -> void:
	base_train_speed = train_speed
	spawn_position = position
	$Area2D.add_to_group("plateforme")
	timer.timeout.connect(_reset_position)
	timer.start()

func _physics_process(delta: float) -> void:
	position.x += train_speed * delta

func _reset_position() -> void:
	position = spawn_position
	timer.start()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("train_stop"):
		_slow_down_train()
		

func _slow_down_train() -> void:
	var tween = create_tween()
	tween.tween_property(self, "train_speed", 0, 1.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	tween.tween_interval(2.0)
	tween.tween_callback(_restart_train)

func _restart_train() -> void:
	var tween = create_tween()
	tween.tween_property(self, "train_speed", base_train_speed, 3.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
