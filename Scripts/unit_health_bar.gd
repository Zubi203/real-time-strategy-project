extends ProgressBar

@export var unit: Unit

func _ready() -> void:
	if unit:
		max_value = unit.max_health
		_update_value(unit.max_health)
		unit.OnChangeHealth.connect(_update_value)

func _update_value(health: int):
	value = health
	visible = value < max_value
