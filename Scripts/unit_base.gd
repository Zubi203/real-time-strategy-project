extends Area2D
class_name Unit

signal OnChangeHealth (health: int)

@export var move_speed: float = 3.0

@export var current_health: int = 10
@export var max_health: int = 10

@export var attack_damage: int = 1
@export var attack_range: float = 20.0
@export var attack_rate: float = 0.5
var last_attack_time: float


enum Team {
	PLAYER,
	AI
}
@export var team: Team

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var attack_target: Unit


func _process(delta: float) -> void:
	if not navigation_agent.is_navigation_finished():
		_move(delta)
	_target_check()

func _move(delta: float):
	var target_position = navigation_agent.get_next_path_position()
	var direction = (target_position - global_position).normalized()
	var movement = direction * move_speed * delta
	translate(movement)


func _target_check():
	if attack_target == null:
		return
	
	var distance_from_target = global_position.distance_to(attack_target.global_position)
	
	if distance_from_target <= attack_range:
		navigation_agent.target_position = global_position
		_try_attack_target()
	else:
		navigation_agent.target_position = attack_target.global_position

func _try_attack_target():
	var time = Time.get_unix_time_from_system()
	
	if time - last_attack_time < attack_rate:
		return
	
	last_attack_time = time
	attack_target.take_damage(attack_damage)

func set_move_target(target: Vector2):
	navigation_agent.target_position = target
	attack_target = null

func set_attack_target(target: Unit):
	if target.team == team:
		return
	
	attack_target = target

func take_damage(amount: int):
	current_health -= amount
	OnChangeHealth.emit(current_health)
	if current_health <= 0:
		_die()


func _die():
	EventBus.OnUnitDie.emit(self)
	queue_free()
