extends RefCounted
class_name AIContext

var creature: CreatureBase

var movement: MovementComponent
var health: HealthComponent


func _init(creature_node: CreatureBase) -> void:
	creature = creature_node
	health = creature.health
	movement = creature.movement
