extends Node
class_name AIStateMachine


@export var states: Array[AIState]

var state_map: Dictionary[StringName, AIState] = {}

var current_state: AIState

var blackboard: Blackboard

func initialize(_context: AIContext, _blackboard: Blackboard) -> void:
	blackboard = _blackboard

	build_state_map()
	
	for state in states:
		state.initialize(_context, _blackboard, self)

func build_state_map() -> void:
	for state in states:
		state_map[state.get_state_id()] = state


func change_state(state_name: StringName) -> void:
	var new_state : AIState = state_map.get(state_name)
	if new_state == null:
		push_error("State not found: " + str(state_name))
		return

	if current_state:
		current_state.exit()

	current_state = new_state
	current_state.enter()

	
func update(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	
func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
