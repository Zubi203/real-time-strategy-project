extends AudioStreamPlayer

@export var take_damage_sfx : AudioStream
@onready var unit: Unit = get_parent()

func _ready() -> void:
	if unit:
		unit.OnChangeHealth.connect(_play_take_damage_sfx)

func _play_take_damage_sfx(health: int):
	if take_damage_sfx:
		_play_sound(take_damage_sfx)

func _play_sound(sound: AudioStream):
	stream = sound
	play()
