extends Line2D

var queue: Array
@export var max_points: int = 20
var should_draw_line := true

func _ready() -> void:
	Events.on_player_died.connect(on_player_death)

func _process(delta: float) -> void:
	if not should_draw_line:
		return
	var pos = get_parent().global_position
	queue.push_front(pos)
	if queue.size() > max_points:
		queue.pop_back()
	clear_points()
	print(points)
	for point in queue:
		add_point(point)

func on_player_death():
	clear_points()
	queue.clear()
	should_draw_line = false
	await get_tree().create_timer(1).timeout
	should_draw_line = true
