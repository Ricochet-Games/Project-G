extends Node
class_name Goal

@export var priority: int = 0
@export var minimum_active_time: float = 1.0

var context: AIContext
var blackboard: Blackboard

var active: bool = false
var active_time: float = 0.0

func initialize(_context: AIContext, _blackboard: Blackboard) -> void:
	context = _context
	blackboard = _blackboard

func evaluate() -> float:
	return 0.0

func enter() -> void:
	active = true
	active_time = 0.0
	blackboard.current_goal = name

func exit() -> void:
	active = false

func update(delta: float) -> void:
	active_time += delta

func can_exit() -> bool:
	return active_time >= minimum_active_time
