extends AIState
class_name SleepState

func enter() -> void:
	blackboard.is_sleeping = true
	super()

func exit() -> void:
	blackboard.is_sleeping = false
	super()
