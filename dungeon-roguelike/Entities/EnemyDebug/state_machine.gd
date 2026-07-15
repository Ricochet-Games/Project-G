extends Node
class_name StateMachine

var active: bool = false
var current_state: State = null
var states: Array[State]
	
var context: AIContext
var blackboard: Blackboard

func initialize(_context: AIContext, _blackboard: Blackboard) -> void:

	context = _context
	blackboard = _blackboard
	register_states()
	#start_initial_state()


func register_states() -> void:
	var i : int = 0
	for child in get_children():
		if child is State:
			states.append(child)
		i+=1

	for state: State in states:
		state.initialize(context, blackboard, self)

func start_initial_state() -> void:
	if states.is_empty():
		return
		
	#var first_state: State = states.values()[0]
#	change_state(first_state)


func update(delta: float) -> void:
	if current_state == null:
		return
		
	check_transitions()
	current_state.update(delta)


func check_transitions() -> void:
	for transition in current_state.transitions:
		if transition.can_transition():
			if transition.target_state:
				change_state(transition.target_state)
			
			transition.on_transition()
			return


func change_state(new_state: State) -> void:
	if new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	current_state = new_state
	blackboard.current_state = current_state.name
	current_state.enter()
