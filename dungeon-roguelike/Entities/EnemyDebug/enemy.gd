extends CharacterBody3D
class_name EnemyBase


@onready var health: HealthComponent = $HealthComponent

@export var speed: float = 3.0
@export var acceleration: float = 10.0

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

var target: Node3D


func _ready() -> void:
	health.died.connect(die)
	target = get_tree().get_first_node_in_group("Player")
	await get_tree().physics_frame

func _physics_process(delta: float) -> void:
	if target == null:
		return

	navigation_agent.target_position = target.global_position

	if navigation_agent.is_navigation_finished():
		velocity = Vector3.ZERO
		move_and_slide()
		return

	var next_position : Vector3 = navigation_agent.get_next_path_position()
	var direction : Vector3 = global_position.direction_to(next_position)
	direction.y = 0
	direction = direction.normalized()
	var target_velocity : Vector3 = direction * speed



	velocity.x = move_toward(
		velocity.x,
		target_velocity.x,
		acceleration * delta
	)

	velocity.z = move_toward(
		velocity.z,
		target_velocity.z,
		acceleration * delta
	)

	if direction.length() > 0:
		rotation.y = atan2(direction.x, direction.z) - deg_to_rad(90)
	
	# Apply movement
	move_and_slide()



func request_damage(amount: int) -> void:
	health.request_damage(amount)
	

func die() -> void:
	if !multiplayer.is_server():
		return

	destroy.rpc()


@rpc("call_local", "reliable")
func destroy() -> void:
	queue_free()
