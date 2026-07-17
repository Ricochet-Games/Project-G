extends AIState
class_name FleeState

func enter() -> void:
	super()
	update_flee_destination()
	# When I start to flee, I want to pick a target far away and then move there
	# I want to request place to feel to in the threat tracker
	# I want to que the movement component to move there

	
	
func update(delta: float) -> void:
	super(delta)
	# I want to be checking if I reach my location
	# I also want to be checking if I am safe and if I find new threats
	# I need to run from the most threatening thing 
	# Ideally Ill find a path that get me away from all threats
	
#	if context.movement.has_reached_destination():
	#	update_flee_destination()


func exit() -> void:
	super()
	context.movement.stop()

func update_flee_destination() -> void:
	var flee_position : Vector3 = blackboard.threat_tracker.get_flee_position()
	context.movement.move_to(flee_position)
	print(flee_position)
	print(context.creature.global_position)
