extends RefCounted
class_name AIContext

var enemy: EnemyBase

var health: HealthComponent
var vision: VisionComponent
# Add other vars here of note 


func _init(enemy_node: EnemyBase) -> void:
	enemy = enemy_node

	health = enemy.health
	vision = enemy.vision
