extends Node
class_name PreyTracker

## This scipt manages and holds information about actively tracked prey
## Has methods to easily request that information

## Class should know of each creature, its distance, and how danagerous it is.

signal new_prey(threat: Node3D)

@export var primary_prey_multiplier: float = 3.0

@export var known_prey: Array[Node3D] = []
@export var creature : Node3D

@export var debug_target: Node3D

@export var vision_component: VisionComponent 
@export var blackboard: Blackboard


func _ready() -> void:
	vision_component.found_target.connect(add_prey)

func _process(_delta: float) -> void:
	for prey :Node3D in known_prey:
		check_prey(prey)
	
func check_prey(threat: Node3D) -> void:
	if(creature.global_position.distance_to(threat.global_position) > 3):
		known_prey.erase(threat)
	
func is_target_in_range() -> bool:
	if known_prey.size() > 0:
		return true
	return false
	
	
func add_prey(threat: Node3D) -> void:
	if not known_prey.has(threat):
		known_prey.append(threat)
		new_prey.emit(threat)

func remove_prey(prey: Node3D) -> void:
	known_prey.erase(prey)

func get_current_prey() -> Array[Node3D] :
	return known_prey

func get_prey_locaiton() -> void:
	## Can be used to maybe cut off prey in more advanced AI
	pass

func creature_sensed(_creature: CharacterBody3D) -> void: ## What does this do???
	pass
