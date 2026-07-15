extends Goal
class_name PatrolGoal


@export var patrol_score: float = 10.0


func evaluate() -> float:

	if blackboard.target_visible:
		return 0.0

	if blackboard.health_percentage < 0.25:
		return 0.0


	return patrol_score
