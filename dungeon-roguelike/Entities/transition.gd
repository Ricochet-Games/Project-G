extends Node
class_name Transition


@export var target_state: State

var context: AIContext
var blackboard: Blackboard

func initialize(
	_ai_context: AIContext,
	_blackboard: Blackboard
) -> void:

	context = _ai_context
	blackboard = _blackboard

## Override this in child transitions.
##
## Return true when this transition should happen.

func can_transition() -> bool:
	return false

func on_transition() -> void:
	pass
