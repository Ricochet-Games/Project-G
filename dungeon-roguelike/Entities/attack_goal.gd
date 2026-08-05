extends Goal
class_name AttackGoal

func evaluate() -> float:
	
	if true :
		if blackboard.prey_tracker.is_target_in_range():
			return 80

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
