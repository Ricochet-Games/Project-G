extends Node
class_name ThreatTracker

## This scipt manages and holds information about actively tracked threats
## Evaluates the danger value each one presents 
## Has methods to easily request that information

## Class should know of each creature, its distance, and how danagerous it is.

signal new_threat(threat: Node3D)

@export var flee_distance: float = 20.0
@export var primary_threat_multiplier: float = 3.0

@export var known_threats: Array[Node3D] = []
@export var creature : Node3D

@export var debug_target: Node3D

@export var vision_component: VisionComponent 
@export var health_component: HealthComponent

var most_recent_damage_source : Node3D

func _ready() -> void:
	vision_component.found_target.connect(add_threat)
	health_component.damaged.connect(on_damaged_by_threat)

func _process(_delta: float) -> void:
	for threat :Node3D in known_threats:
		check_threat(threat)
	
func check_threat(threat: Node3D) -> void:
	if(creature.global_position.distance_to(threat.global_position) > 3):
		known_threats.erase(threat)
	
	
func add_threat(threat: Node3D) -> void:
	if not known_threats.has(threat):
		known_threats.append(threat)
		new_threat.emit(threat)

func remove_threat(threat: Node3D) -> void:
	known_threats.erase(threat)

func get_current_threats() -> Array[Node3D] :
	return known_threats

func get_flee_position() -> Vector3:
	## I want to switch this to be checking possible positions 
	## and then returning the best one that results in the lowest threat value there
	## this requires the data base of relationships to be built
	
	
	var flee_direction := Vector3.ZERO
	var primary_threat : Node3D  = get_most_dangerous_threat()
	
	for threat in known_threats:
		if not is_instance_valid(threat):
			continue
		
		var threat_value : float = get_threat_value(threat)
		if threat_value <= 0:
			continue
		
		# Make the strongest threat dominate
		if threat == primary_threat:
			threat_value *= primary_threat_multiplier


		var direction := (
			creature.global_position - threat.global_position
		).normalized()


		var distance := creature.global_position.distance_to(threat.global_position)

		# Closer threats have more influence
		var distance_weight : float = 1.0 / max(distance, 1.0)

		## I am not sure about this, i wanna do more tests of the effectiveness in the future
		var random_offset : Vector3 = Vector3(randf_range(-0.3, 0.3),	0, randf_range(-0.3, 0.3))
			
		flee_direction += direction * threat_value * distance_weight
		flee_direction += random_offset


	if flee_direction == Vector3.ZERO:
		return creature.global_position

	if debug_target:
		debug_target.global_position = creature.global_position + flee_direction.normalized() * flee_distance


	return creature.global_position + flee_direction.normalized() * flee_distance

func get_most_dangerous_threat() -> Node3D:
	var highest_value := 0.0
	var strongest_threat: Node3D = null


	for threat in known_threats:
		if not is_instance_valid(threat):
			continue

		var value : float = get_threat_value(threat)

		if value > highest_value:
			highest_value = value
			strongest_threat = threat


	return strongest_threat

func get_threat_value(threat: Node3D) -> float:
	if threat.is_in_group("Player"):
		return 90.0

	if threat.is_in_group("Predator"):
		return 70.0

	if threat.is_in_group("Enemy"):
		return 50.0

	return 0.0
	
func get_threat_level() -> float:
	var highest_threat := 0.0

	for threat in known_threats:
		var value : float = get_threat_value(threat)

		if value > highest_threat:
			highest_threat = value

	return highest_threat

func creature_sensed(_creature: CharacterBody3D) -> void: ## What does this do???
	pass

func on_damaged_by_threat(_amount: float, source: Node3D) -> void:
	most_recent_damage_source = source

func get_threat_to_counter_attack() -> Node3D:
	return most_recent_damage_source
## When gets hurt I need to run a method 
## It needs to check if it should like defend
## and then save what its defending from 
## It goes: if hurt and that causes health below 50 -> find attacker -> attack
