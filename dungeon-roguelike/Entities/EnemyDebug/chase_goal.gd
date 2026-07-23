extends Goal
class_name ChaseGoal

## For testing purposes we will use this script but functionality needs to be changed later
## This should be just chasing
## But Dear beavior is unique in the way that it kinda like defends the pack
## I need a specific goal for it
func evaluate() -> float:
	var sleepiness : float = blackboard.current_sleepiness

	if blackboard.health.current_health < 50:
		return 100

	return 0


func enter() -> void:
	super()
	state_machine.change_state(&"ChaseState")
