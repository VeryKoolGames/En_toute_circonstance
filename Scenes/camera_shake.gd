extends Camera2D

@export var randomStrenght: float = 10
@export var shakeFade: float = 3.0
var rng = RandomNumberGenerator.new();
var shakeStrenght: float = 0.0
var shake_cooldown := 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.on_player_died.connect(on_player_death)

func on_player_death() -> void:
	shakeStrenght = randomStrenght

func _process(delta):
	if shakeStrenght > 0:
		shakeStrenght = lerpf(shakeStrenght, 0, shakeFade * delta)
		offset = randomOffset()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStrenght, shakeStrenght),rng.randf_range(-shakeStrenght, shakeStrenght))
