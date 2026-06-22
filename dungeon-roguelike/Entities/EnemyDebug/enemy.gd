extends CharacterBody3D
class_name EnemyBase


@onready var health: HealthComponent = $HealthComponent

func _ready() -> void:
		health.died.connect(die)

func take_damage(amount: int) -> void:
	health.take_damage(amount)
	

func die():
	queue_free()
