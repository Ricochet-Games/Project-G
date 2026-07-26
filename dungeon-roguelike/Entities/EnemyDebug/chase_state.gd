extends AIState
class_name ChaseState

var target : Node3D

func enter() -> void:
	target = blackboard.threat_tracker.get_threat_to_counter_attack()
	context.movement.move_to(target.global_position)
	
	blackboard.is_chasing = true
	super()

func update(delta: float) -> void:
	

## if im in attack range I need to attacck

	
	
	if blackboard.is_in_attack_range():
		report("in_attack_range")
	else:
		report("out_of_attack_range")
	
	## if I lost the target I need to flee
		#report("lost_target")
	
	context.movement.move_to(target.global_position)
	super(delta)


func exit() -> void:
	blackboard.is_chasing = false
	context.movement.stop()
	super()
