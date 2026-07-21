extends Resource
class_name ThreatCreatureRelationship

@export var creature_id: String

@export_range(0,1)
var minimum_fear: float = 0.2

@export_range(0,1)
var maximum_fear: float = 1.0

@export var danger_distance: float = 10.0
