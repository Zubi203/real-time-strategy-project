extends Camera2D

@export var cam_speed: float = 70.0
@export var zoom_amount: float = 0.2
@export var max_zoom: float = 5.0
@export var min_zoom: float = 1.0

func _process(delta: float) -> void:
	_move(delta)
	_zoom()

func _move(delta: float):
	var dir = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	var zoom_speed_mod = (max_zoom + 1.0) - zoom.x
	var movement = dir * delta * cam_speed * zoom_speed_mod
	translate(movement)

func _zoom():
	var z = zoom.x
	if Input.is_action_just_released("zoom_in"):
		z += zoom_amount
	elif Input.is_action_just_released("zoom_out"):
		z -= zoom_amount
	
	z = clamp(z, min_zoom, max_zoom)
	
	zoom = Vector2(z, z)
