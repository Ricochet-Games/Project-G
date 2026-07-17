class_name AIState
extends Node

var context : AIContext
var blackboard: Blackboard
var state_machine: AIStateMachine

var brain: Brain

## State information
var active: bool = false
var active_time: float = 0.0
@export var minimum_active_time: float = 1.0

func initialize(_context: AIContext, _blackboard: Blackboard, _state_machine: AIStateMachine) -> void: #, p_state_machine: StateMachine
	context = _context
	blackboard = _blackboard
	state_machine = _state_machine

func enter() -> void:
	active = true
	active_time = 0.0


func update(delta: float) -> void:
	active_time += delta

func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	active = false

func can_enter() -> bool:
	return true

func can_exit() -> bool:
	return active_time >= minimum_active_time

func request_transition(_state_name: StringName) -> void:
	pass
	#state_machine.change_state(state_name, msg)

func get_state_id() -> StringName:
	return get_script().get_global_name()
