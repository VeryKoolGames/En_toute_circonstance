extends Node2D

var should_follow_mouse := false
var level_image: Image
var level_origin: Vector2
var background_color := Color(0.1333, 0.1137, 0.3255, 1.0)
var spawn_position: Vector2

func _ready() -> void:
	$Area2D.add_to_group("player")
	spawn_position = global_position
	_get_level_image_info()
	Events.on_player_died.connect(on_player_death)

func _get_level_image_info():
	var tex = preload("res://Sprites/LEVEL.png") as CompressedTexture2D
	level_image = tex.get_image()
	level_origin = %Level.global_position - tex.get_size() / 2

func _process(delta: float) -> void:
	var world_pos = global_position
	var image_pos = (world_pos - level_origin).floor()

	var pixel_color = level_image.get_pixelv(image_pos)
	if is_inside_image(image_pos):
		if is_on_death_color(pixel_color):
			Events.on_player_died.emit()
		if should_follow_mouse:
			global_position = get_global_mouse_position()

func is_inside_image(pos: Vector2) -> bool:
	return pos.x >= 0 and pos.y >= 0 and pos.x < level_image.get_width() and pos.y < level_image.get_height()

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("mouse_pressed"):
		should_follow_mouse = true

func maze_image_size_to_pixel(world_pos: Vector2) -> Vector2i:
	return Vector2i(world_pos.round())

func is_on_death_color(color: Color, tolerance := 0.05) -> bool:
	return abs(color.r - background_color.r) <= tolerance and \
		   abs(color.g - background_color.g) <= tolerance and \
		   abs(color.b - background_color.b) <= tolerance

func on_player_death():
	should_follow_mouse = false
	global_position = spawn_position

func set_respawn_point(new_pos: Vector2) -> void:
	spawn_position = new_pos
