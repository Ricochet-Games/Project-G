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
var state_machine: AIStateMachine
var ai_controller : AIController
@export var goals: Array[Goal]
var current_goal: Goal  = null


func initialize(_context : AIContext, _blackboard: Blackboard, _state_machine: AIStateMachine, _ai_controller : AIController) -> void:
	context = _context
	state_machine = _state_machine
	blackboard = _blackboard
	ai_controller = _ai_controller
	
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
		return
		
		
	if current_goal:
		current_goal.exit()
		
	
	if current_goal: 
		print(context.creature.name + " is switching from " + str(current_goal.name) + " to " + str(new_goal.name))
	current_goal = new_goal
	if ai_controller.enemy_debug_info && ai_controller.debug_creature:
		ai_controller.enemy_debug_info.update_goal(current_goal.get_script().get_global_name())
	if current_goal:
		current_goal.enter()
