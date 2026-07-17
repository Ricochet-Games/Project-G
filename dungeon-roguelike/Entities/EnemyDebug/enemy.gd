extends CharacterBody3D
class_name CreatureBase


@export var health: HealthComponent 
@export var vision: VisionComponent 
@export var movement: MovementComponent 
#@onready var attack = $AttackComponent

var target: Node3D


func _ready() -> void:
	health.died.connect(die)
	target = get_tree().get_first_node_in_group("Player")
	await get_tree().physics_frame

func request_damage(amount: int) -> void:
	health.request_damage(amount)
	

func die() -> void:
	if !multiplayer.is_server():
		return

	destroy.rpc()


@rpc("call_local", "reliable")
func destroy() -> void:
	queue_free()
