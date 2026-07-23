extends Goal
class_name SleepGoal

#@export var max_sleep_prority : float = 60
#@export var min_sleep_prority : float = 50

func evaluate() -> float:
	var sleepiness : float = blackboard.current_sleepiness

	if blackboard.is_sleeping:
		return 50 # What I like to call sleep momentum

	if sleepiness > 100:
		return 100

	if sleepiness > 50:
		return 20

	return 0


func enter() -> void:
	super()
	state_machine.change_state(&"SleepState")
