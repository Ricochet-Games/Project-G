extends Node
class_name Brain

## This script manages the different parts of the creatures brain 
## Each create is broken down into seperate wants / goals 
## For example Fleeing if hurt or stalking prey 
## Here, we will balance the different needs of a creature to decide what to do next
@warning_ignore("unused_signal")
signal goal_changed(new_goal_name: String)

@export var blackboard : Blackboard
var context: AIContext

@export var goals: Array[Goal]
var current_goal: Goal  = null


func initialize(_context : AIContext, _blackboard: Blackboard, _state_machine: AIStateMachine) -> void:
	context = _context
	blackboard = _blackboard
	
	for goal in goals:
		goal.initialize(_blackboard, _state_machine)

func update(delta: float) -> void:
	var best_goal : Goal = evaluate_goals()
	if best_goal != current_goal:
		switch_goal(best_goal)
		
	if current_goal:
		current_goal.update(delta)


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
	if current_goal and !current_goal.can_exit():
		#print("Can't exit out of " + str(current_goal))
		return
		
		
	if current_goal:
		current_goal.exit()
	
	print("Switching from " + str(current_goal) + " to " + str(new_goal))
	current_goal = new_goal
	
	if current_goal:
		current_goal.enter()
