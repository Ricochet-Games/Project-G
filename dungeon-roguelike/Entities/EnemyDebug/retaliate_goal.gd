extends Goal
class_name RetaliateGoal

## For testing purposes we will use this script but functionality needs to be changed later
## This should be just chasing
## But Dear beavior is unique in the way that it kinda like defends the pack
## I need a specific goal for it
func evaluate() -> float:
	if blackboard.health.current_health < 50:
		return 100

	return 0


func enter() -> void:
	super()
	state_machine.change_state(&"ChaseState")

func on_state_event(event: String) -> void:
	print(event)
	match event:
		"in_attack_range":
			state_machine.change_state(&"AttackState")

		"target_out_of_range":
			state_machine.change_state(&"ChaseState")

		"target_dead":
			pass
			#end_goal()

		"target_lost":
			pass
			#end_goal()
