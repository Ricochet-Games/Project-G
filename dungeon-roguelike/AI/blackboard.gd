extends Node
class_name Blackboard

## This script holds all the needed information to make choices within the AI
## Most Module logic should be self contained
## However, this will hold the final result that those modules provide 

@export var threat_tracker : ThreatTracker
@export var creature_data : CreatureData

@export var health : HealthComponent
var current_threat: Node3D
var is_fleeing : bool = false

var creature : CreatureBase 

var current_goal : Goal
var confidence : float ## 100


## decreases to 0 over time, attacking and fleeing speeds up the decrease
## Entering the sleep state reduces sleepiness

var is_sleeping: bool = false
var max_sleepiness: float = 100
var current_sleepiness: float 
var sleep_rate: float = 0.1 # We prob should change this sometime maybe idk

var current_prey: Node3D
var is_chasing: bool = false

func _process(delta: float) -> void:
	update_sleep(delta)

func update_sleep(delta: float) -> void:
	var current_sleep_rate : float = sleep_rate
	## Need to change these values from being hard coded as 5
	if is_fleeing:
		current_sleep_rate *= 5
	elif is_sleeping:
		current_sleep_rate *= -5
		
	current_sleepiness = clampf(current_sleepiness + delta * current_sleep_rate, 0.0, 100.0)

func get_prey() -> Node3D:
	return current_prey
