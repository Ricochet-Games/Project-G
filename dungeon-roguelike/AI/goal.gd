extends Node
class_name Goal

@export var priority: int = 0
@export var minimum_active_time: float = 1.0

var blackboard: Blackboard
var state_machine: AIStateMachine

var active: bool = false
var active_time: float = 0.0


func initialize(_blackboard: Blackboard, _state_machine: AIStateMachine) -> void:
	blackboard = _blackboard
	state_machine = _state_machine


func evaluate() -> float:
	return 1


func enter() -> void:
	active = true
	active_time = 0.0
	blackboard.current_goal = self


func exit() -> void:
	active = false


func update(delta: float) -> void:
	active_time += delta


func can_exit() -> bool:
	return true #active_time >= minimum_active_time
