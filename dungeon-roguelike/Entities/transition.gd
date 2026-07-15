extends Node
class_name Transition

var current_state : State
@export var next_state : State 
signal transition(new_stae: State)

func _ready() -> void:
	current_state = get_parent() as State
	print(get_parent())
	
func start_transiton(_target: Node3D)-> void:
	print(current_state)
	#transition.emit(next_state)
	print(current_state.state_machine)
	next_state.state_machine.change_state(next_state)
