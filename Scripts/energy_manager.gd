extends Node

var is_using_energy: bool
var is_charging: bool
@onready var energy_timer: Timer = $Timer
@onready var charging_timer: Timer = $ChargingTimer
@onready var charging_sound: AudioStreamPlayer2D = $ChargeUpSound
@export var energy_progress_bar: ProgressBar
@export var total_energy_timer: FloatValue

func _ready() -> void:
	energy_progress_bar.max_value = total_energy_timer.value
	energy_progress_bar.value = energy_progress_bar.max_value
	Events.on_charging_zone_exited.connect(_start_using_energy)
	Events.on_charging_zone_entered.connect(_start_charging)
	Events.on_ending_reached.connect(_stop_energy_logic)
	energy_timer.timeout.connect(on_energy_empty)
	_start_using_energy()

func _physics_process(delta: float) -> void:
	if is_using_energy:
		energy_progress_bar.value = energy_timer.time_left
	elif is_charging:
		energy_progress_bar.value += (charging_timer.wait_time - charging_timer.time_left)
		if energy_progress_bar.value >= energy_progress_bar.max_value:
			charging_sound.playing = false

func _start_charging():
	is_using_energy = false
	is_charging = true
	charging_sound.playing = true
	energy_timer.stop()
	charging_timer.start(energy_timer.time_left)

func _start_using_energy():
	is_using_energy = true
	is_charging = false
	charging_sound.playing = false
	energy_timer.start(energy_progress_bar.max_value)
	charging_timer.stop()

func on_energy_empty():
	Events.on_energy_emptied.emit()

func _stop_energy_logic():
	is_charging = false
	is_using_energy = false
	energy_timer.stop()
	charging_timer.stop()
