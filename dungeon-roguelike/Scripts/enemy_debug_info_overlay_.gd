extends Control
class_name EnemyDebugInfoOverlay

@onready var goal: Label = $MarginContainer/VBoxContainer/Goal
@onready var state: Label = $MarginContainer/VBoxContainer/State
@onready var target: Label = $MarginContainer/VBoxContainer/Target


func update_goal(current_goal: String) -> void:
	goal.text = "Goal: " + current_goal
	

func update_state(current_state: String) -> void:
	state.text = "State: " + current_state
	
	
## Display:
## Goal
## State
## Target
## XXX
