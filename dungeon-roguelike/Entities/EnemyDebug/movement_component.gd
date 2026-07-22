extends Node

class_name MovementComponent

signal arrived
signal movement_stopped
signal destination_unreachable

@export var body: CharacterBody3D
@export var navigation_agent: NavigationAgent3D

@export var move_speed: float = 4.0
@export var acceleration: float = 12.0
@export var rotation_speed: float = 8.0

var _target: Vector3
var _stopping_distance: float = 1.5
var _moving := false
var _follow_target := false


func _physics_process(delta: float) -> void:
	if !_moving:
		return

	if _target == null:
		stop()
		return

	# Update path if following a moving target
	if _follow_target:
		navigation_agent.target_position = _target

	var distance := body.global_position.distance_to(_target)

	# Close enough
	if distance <= _stopping_distance:
		stop()
		arrived.emit()
		return

	# Navigation couldn't find a path
	if navigation_agent.is_navigation_finished():
		stop()
		destination_unreachable.emit()
		return

	var next_position := navigation_agent.get_next_path_position()
	var direction := next_position - body.global_position
	direction.y = 0

	if direction.length_squared() < 0.001:
		body.velocity = Vector3.ZERO
		body.move_and_slide()
		return

	direction = direction.normalized()

	var desired_velocity := direction * move_speed

	body.velocity.x = move_toward(
		body.velocity.x,
		desired_velocity.x,
		acceleration * delta
	)

	body.velocity.z = move_toward(
		body.velocity.z,
		desired_velocity.z,
		acceleration * delta
	)

	body.move_and_slide()

	_rotate(direction, delta)



func move_to(target: Vector3, stopping_distance: float = 1.5) -> void:
	if target == null:
		return

	_target = target
	_stopping_distance = stopping_distance
	_follow_target = false
	_moving = true

	navigation_agent.target_position = target


func follow(target: Vector3, stopping_distance: float = 2.0) -> void:
	if target == null:
		return

	_target = target
	_stopping_distance = stopping_distance
	_follow_target = true
	_moving = true

	navigation_agent.target_position = target


func stop() -> void:
	_moving = false
	body.velocity = Vector3.ZERO
	body.move_and_slide()
	movement_stopped.emit()


func is_moving() -> bool:
	return _moving


func has_reached_destination() -> bool:
	return !_moving


func _rotate(direction: Vector3, delta: float) -> void:
	var target_basis := Basis.looking_at(direction, Vector3.UP)
	body.basis = body.basis.slerp(target_basis, rotation_speed * delta)
