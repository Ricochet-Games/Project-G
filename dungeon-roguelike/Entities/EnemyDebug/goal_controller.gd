extends Node
class_name GoalController

## Maps goal names to state machines
##
## Example:
## "Combat" -> CombatStateMachine
## "Explore" -> ExplorationStateMachine

@export var goal_state_machines: Dictionary



var brain: Brain
var current_goal: String = ""

func initialize(_ai_brain: Brain) -> void:
	brain = _ai_brain
	brain.goal_changed.connect(_on_goal_changed)

func _on_goal_changed(new_goal: String) -> void:
	if new_goal == current_goal:
		return
		
	current_goal = new_goal
	switch_goal(new_goal)

func switch_goal(goal_name: String) -> void:
	disable_all_state_machines()
	
	if !goal_state_machines.has(goal_name):
		return
	
	var machine = goal_state_machines[goal_name]
	machine.activate()

func disable_all_state_machines() -> void:
	for machine in goal_state_machines.values():
		machine.deactivate()
