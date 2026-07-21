extends Node
class_name Blackboard

## This script holds all the needed information to make choices within the AI
## Most Module logic should be self contained
## However, this will hold the final result that those modules provide 

@export var threat_tracker : ThreatTracker
@export var creature_data : CreatureData
var current_threat: Node3D

var creature : CreatureBase 

var current_goal : Goal
var confidence : float ## 100
