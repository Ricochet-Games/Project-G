extends Goal
class_name FleeGoal

@export var flee_threshold: float = 60.0


func evaluate() -> float:
	var fear : float = blackboard.threat_tracker.get_threat_level()

	if fear < flee_threshold:
		return 0.0

	return priority + fear


func enter() -> void:
	super()
	state_machine.change_state(&"FleeState")
	
func can_exit() -> bool:
	## THIS NEEDS TO CHECK IF YOUVE REACHED END POITN AND NO FEAR
	var fear : float = blackboard.threat_tracker.get_threat_level()
	var flee_state : FleeState = state_machine.current_state
	

	
	if fear > flee_threshold or !flee_state.has_reached_safe_position():
		if blackboard.health.current_health < 50:
			return true
			
		return false

	return true
