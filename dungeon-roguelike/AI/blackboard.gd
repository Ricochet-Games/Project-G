extends Node
class_name Blackboard

## This script holds all the needed information to make choices within the AI
## Most Module logic should be self contained
## However, this will hold the final result that those modules provide 

@export var threat_tracker : ThreatTracker
@export var creature_data : CreatureData
var current_threat: Node3D
var is_fleeing : bool = false

var creature : CreatureBase 

var current_goal : Goal
var confidence : float ## 100

## decreases to 0 over time, attacking and fleeing speeds up the decrease
## Entering the sleep state reduces sleepiness
var sleepiness: float 
var sleep_rate: float = 0.1 # We prob should change this sometime maybe idk

func _process(delta: float) -> void:
	var current_sleep_rate : float = sleep_rate
	if is_fleeing:
		current_sleep_rate *= 5
		
	sleepiness = clampf(sleepiness + delta * current_sleep_rate, 0.0, 100.0)
