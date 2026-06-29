extends CharacterBody3D
class_name EnemyBase


@onready var health: HealthComponent = $HealthComponent

func _ready() -> void:
		health.died.connect(die)

func request_damage(amount: int) -> void:
	health.request_damage(amount)
	

func die() -> void:
	if !multiplayer.is_server():
		return

	destroy.rpc()


@rpc("call_local", "reliable")
func destroy() -> void:
	queue_free()
