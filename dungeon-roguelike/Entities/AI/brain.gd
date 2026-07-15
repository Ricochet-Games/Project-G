extends Node
class_name Brain

signal goal_changed(new_goal_name: String)

@export var goals: Array[Goal]
var current_goal: Goal  = null

var context: AIContext
var blackboard: Blackboard

func initialize(_context: AIContext, 	_blackboard: Blackboard) -> void:
	context = _context
	blackboard = _blackboard
	
	for goal in goals:
		goal.initialize(context, blackboard)

func update(delta: float) -> void:
	var best_goal : Goal = evaluate_goals()
	if best_goal != current_goal:
		switch_goal(best_goal)
		
	if current_goal:
		current_goal.update(delta)
	print(current_goal)

## Add a chcek here for if goal can be switched too
## Don't want to return a failed goal state
func evaluate_goals() -> Goal:
	var highest_score := -1.0
	var selected_goal : Goal = null
	
	for goal in goals:
		var score : float = goal.evaluate()
		
		if score > highest_score:
			highest_score = score
			selected_goal = goal
		
	return selected_goal


func switch_goal(new_goal: Node) -> void:
	if current_goal:
		current_goal.exit()
		
	current_goal = new_goal
	
	if current_goal:
		current_goal.enter()
