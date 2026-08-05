extends Node
class_name AIStateMachine


@export var states: Array[AIState]

var state_map: Dictionary[StringName, AIState] = {}

var current_state: AIState
var brain: Brain
var blackboard: Blackboard
var ai_controller: AIController

func initialize(_context: AIContext, _blackboard: Blackboard, _brain: Brain, _ai_controller) -> void:
	blackboard = _blackboard
	brain = _brain
	ai_controller = _ai_controller
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
		if current_state.state_event.is_connected(brain.current_goal.on_state_event):
			current_state.state_event.disconnect(brain.current_goal.on_state_event)
		current_state.exit()

	current_state = new_state
	if ai_controller.enemy_debug_info:
		ai_controller.enemy_debug_info.update_state(str(current_state.get_state_id()))
	current_state.enter()
	current_state.state_event.connect(brain.current_goal.on_state_event)
	
func update(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	
func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
