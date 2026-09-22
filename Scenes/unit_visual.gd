extends Sprite2D

@onready var unit: Unit = get_parent()

var unit_pos_last_frame: Vector2
@export var move_sway_rate: float = 0.1
@export var move_sway_magnitude: float = 5.0

func _ready() -> void:
	if unit:
		unit.OnChangeHealth.connect(_damage_flash)

func _process(delta: float) -> void:
	var time = Time.get_unix_time_from_system()
	
	var rot = sin(time * (1 / move_sway_rate)) * move_sway_magnitude
	
	if unit_pos_last_frame == unit.global_position:
		rot = 0
	
	rotation = deg_to_rad(rot)
	var dir = unit.global_position.x - unit_pos_last_frame.x
	flip_h = dir < 0
	unit_pos_last_frame = unit.global_position

func _damage_flash(health: int):
	modulate = Color.RED
	await get_tree().create_timer(0.05).timeout
	modulate = Color.WHITE
