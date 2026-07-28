extends Goal
class_name RetaliateGoal

## For testing purposes we will use this script but functionality needs to be changed later
## This should be just chasing
## But Dear beavior is unique in the way that it kinda like defends the pack
## I need a specific goal for it
func evaluate() -> float:
	
	## if it is hit recently and then in range and health under
	
	if blackboard.health.current_health < 50 :
		if blackboard.time_since_last_hit.time_left <= 0 \
		and blackboard.get_distance_to_creature_to_attack() > 2: ## if player re-enters then it auto attacks
			return 0
		
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

		"out_of_attack_range":
			state_machine.change_state(&"ChaseState")

		"target_dead":
			pass
			#end_goal()

		"target_lost":
			pass
			#end_goal()
