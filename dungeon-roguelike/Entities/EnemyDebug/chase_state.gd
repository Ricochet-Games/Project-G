extends AIState
class_name ChaseState

var target : Node3D

func enter() -> void:
	target = blackboard.threat_tracker.get_threat_to_counter_attack()
	context.movement.move_to(target.global_position)
	
	blackboard.is_chasing = true
	super()

func update(delta: float) -> void:
	context.movement.move_to(target.global_position)
	super(delta)

## if I lost target I need to stop following
## for the deer I need to then return to the pack
## this is starting to get out of hand for the number of edge cases for complex behavior 
## maybe doesnt have to return to pack but still needs to disengage
## needs to sleep, eat, drink to increase health, could switch back to flee 

func exit() -> void:
	blackboard.is_chasing = false
	context.movement.stop()
	super()
