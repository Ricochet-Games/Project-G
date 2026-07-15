extends Node
class_name State

var context: AIContext
var blackboard: Blackboard

var state_machine: StateMachine

var transitions: Array[Transition] = []


func initialize(
	_ai_context: AIContext,
	_blackboard: Blackboard,
	_machine: StateMachine
) -> void:

	context = _ai_context
	blackboard = _blackboard
	state_machine = _machine

	for transition in transitions:
		transition.initialize(
			context,
			blackboard
		)


func enter() -> void:
	blackboard.current_state = name

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
