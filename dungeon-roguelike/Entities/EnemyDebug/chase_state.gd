extends AIState
class_name ChaseState

var target : Node3D

func enter() -> void:
	blackboard.prey_tracker.new_prey.connect(new_prey)
	##target = blackboard.get_attack_target()
	
	print(target)
	context.movement.move_to(target.global_position)
	
	blackboard.is_chasing = true
	super()

func update(delta: float) -> void:
	

## if im in attack range I need to attacck

	
	
	if blackboard.is_in_attack_range():
		report("in_attack_range")
	
	## if I lost the target I need to flee
		#report("lost_target")
	
	context.movement.move_to(target.global_position)
	super(delta)

func new_prey(_prey: Node3D) -> void:
	target = _prey

func exit() -> void:
	blackboard.prey_tracker.new_prey.disconnect(new_prey)
	blackboard.is_chasing = false
	context.movement.stop()
	super()
