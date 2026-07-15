extends Goal
class_name CombatGoal


@export var target_visible_score: float = 100.0
@export var remembered_target_score: float = 40.0


func evaluate() -> float:

	if blackboard.target == null:
		return 0.0
	
	if blackboard.target_visible:
		return target_visible_score
	
	if blackboard.last_known_position != Vector3.ZERO:
		return remembered_target_score
	
	return 0.0
