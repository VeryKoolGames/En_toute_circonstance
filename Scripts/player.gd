extends Node2D

var should_follow_mouse := false
var gravity_zone_active := false
var is_first_pressed := true
var level_image: Image
var level_origin: Vector2
var background_color := Color(0.1333, 0.1137, 0.3255, 1.0)
var spawn_position: Vector2
var original_spawn_position: Vector2
@onready var car_sound: AudioStreamPlayer2D = $CarSound
@onready var car_crash_sound: AudioStreamPlayer2D = $CarCrashSound
@onready var charging_particles: CPUParticles2D = $RechargeParticles
@onready var death_particles: CPUParticles2D = $ExplosionParticules
@onready var car_halo: Sprite2D = $CarHalo

# PLATEFORM LOGIC

var is_player_safe: bool
var plateform_count: int

func _ready() -> void:
	$Area2D.add_to_group("player")
	spawn_position = global_position
	original_spawn_position = global_position
	_get_level_image_info()
	Events.on_player_died.connect(on_player_death)
	Events.on_energy_emptied.connect(reset_player_to_start_position)
	Events.on_gravity_zone_entered.connect(on_gravity_zone_entered)
	Events.on_gravity_zone_exited.connect(on_gravity_zone_exited)
	Events.on_charging_zone_entered.connect(on_charging_zone_entered)
	Events.on_charging_zone_exited.connect(on_charging_zone_exited)

# MOVEMENT LOGIC

func _get_level_image_info() -> void:
	var tex = preload("res://Sprites/LEVEL.png") as CompressedTexture2D
	level_image = tex.get_image()
	level_origin = %Level.global_position - tex.get_size() / 2

func _process(delta: float) -> void:
	var world_pos = global_position
	var image_pos = (world_pos - level_origin).floor()

	if is_inside_image(image_pos):
		var pixel_color = level_image.get_pixelv(image_pos)
		#if is_on_death_color(pixel_color) and not is_player_safe:
			#Events.on_player_died.emit()
		if should_follow_mouse:
			var target_position = get_global_mouse_position()
			if gravity_zone_active:
				global_position = global_position.lerp(target_position, 0.02) 
			else:
				global_position = target_position

func is_inside_image(pos: Vector2) -> bool:
	return pos.x >= 0 and pos.y >= 0 and pos.x < level_image.get_width() and pos.y < level_image.get_height()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_pressed"):
		if is_first_pressed:
			remove_halo()
			is_first_pressed = false
		should_follow_mouse = not should_follow_mouse
		car_sound.playing = not car_sound.playing
		if should_follow_mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func remove_halo():
	scale = Vector2(1, 1)
	car_halo.queue_free()

func is_on_death_color(color: Color, tolerance := 0.05) -> bool:
	return abs(color.r - background_color.r) <= tolerance and \
		   abs(color.g - background_color.g) <= tolerance and \
		   abs(color.b - background_color.b) <= tolerance

func on_player_death() -> void:
	death_particles.emitting = true
	car_crash_sound.playing = true
	should_follow_mouse = false
	global_position = spawn_position
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func reset_player_to_start_position():
	position = original_spawn_position

func set_respawn_point(new_pos: Vector2) -> void:
	spawn_position = new_pos

# CHARGING ZONE LOGIC

func on_charging_zone_entered():
	charging_particles.emitting = true

func on_charging_zone_exited():
	charging_particles.emitting = false

# GRAVITY LOGIC

func on_gravity_zone_entered():
	gravity_zone_active = true
	
func on_gravity_zone_exited():
	if not gravity_zone_active:
		return
	gravity_zone_active = false

# PLATEFORME LOGIC

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("plateforme"):
		is_player_safe = true
		plateform_count += 1


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("plateforme"):
		plateform_count -= 1
		if plateform_count == 0:
			is_player_safe = false
