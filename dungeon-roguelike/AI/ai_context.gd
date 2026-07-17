extends RefCounted
class_name AIContext

var creature: CreatureBase

var movement: MovementComponent


func _init(creature_node: CreatureBase) -> void:
	creature = creature_node
	
	movement = creature.movement
