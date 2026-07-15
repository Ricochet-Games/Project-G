extends Node
class_name Blackboard


## Current entity this AI cares about
var target: Node3D = null
var target_visible: bool = false
var last_known_position: Vector3 = Vector3.ZERO
var target_distance: float = INF

var last_damage_source: Node3D = null
var recently_damaged: bool = false
var time_since_damage: float = 0.0

var health_percentage: float = 1.0
var is_dead: bool = false
var is_stunned: bool = false

var is_attacking: bool = false
var can_attack: bool = false
var attack_target_in_range: bool = false

var destination: Vector3 = Vector3.ZERO
var has_destination: bool = false
var reached_destination: bool = false

var heard_noise: bool = false
var noise_position: Vector3 = Vector3.ZERO

var current_goal: String = ""
var current_state: String = ""

var suspicion: float = 0.0
var aggression: float = 0.0
var fear: float = 0.0


func set_target(new_target: Node3D) -> void:
	print(new_target)
	target = new_target
	
	if target:
		update_target_position()

func clear_target() -> void:
	target = null
	target_visible = false
	target_distance = INF

func update_target_position() -> void:
	if target == null:
		return
	
	last_known_position = target.global_position

@warning_ignore("shadowed_variable_base_class")
func update_target_distance(owner: Node3D) -> void:
	if target == null:
		target_distance = INF
		return
	
	target_distance = owner.global_position.distance_to(target.global_position)
	
func reset_noise() -> void:
	heard_noise = false
	noise_position = Vector3.ZERO

func register_damage(source: Node3D) -> void:
	last_damage_source = source
	recently_damaged = true
	time_since_damage = 0.0

func update(delta: float) -> void:
	time_since_damage += delta
	
	if time_since_damage > 5.0:
		recently_damaged = false
