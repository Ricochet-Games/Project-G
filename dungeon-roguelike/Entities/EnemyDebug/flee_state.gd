extends AIState
class_name FleeState

func has_reached_safe_position() -> bool:
	return context.movement.has_reached_destination()
	
	
func new_threat(threat: Node3D) -> void:
	update_flee_destination()
	pass

func enter() -> void:
	blackboard.threat_tracker.new_threat.connect(new_threat)
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
	
	## Every second that I have something 'chasing me' 
	## i need to be making a new path that gets me out of the area
	
	if blackboard.threat_tracker.known_threats.size() > 0: 
		update_flee_destination() 
		
	
		## If im still in danager, flee again
		## If not then I can leave flee 
	#	update_flee_destination()


func exit() -> void:
	super()
	context.movement.stop()

func update_flee_destination() -> void:
	var flee_position : Vector3 = blackboard.threat_tracker.get_flee_position()
	context.movement.move_to(flee_position)
