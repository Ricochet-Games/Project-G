extends Node
class_name StateMachine

@export var starting_state: State

var current_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			child.enemy = owner
			child.state_machine = self

	change_state(starting_state)

func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state

	if current_state:
		current_state.enter()

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
