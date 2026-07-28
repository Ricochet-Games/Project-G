extends Goal
class_name WanderGoal


func evaluate() -> float:
	return 10

func enter() -> void:
	super()
	state_machine.change_state(&"WanderState")
