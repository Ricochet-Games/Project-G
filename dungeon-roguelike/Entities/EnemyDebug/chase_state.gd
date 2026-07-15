extends State
class_name ChaseState

@export var target: Node3D
@export var navigation_agent: NavigationAgent3D 

@export var speed: float = 3.0
@export var acceleration: float = 10.0

func enter() -> void:
	pass

func exit() -> void:
	pass

func physics_update(delta: float) -> void:
	if target == null:
		return

	navigation_agent.target_position = target.global_position

	if navigation_agent.is_navigation_finished():
		enemy.velocity = Vector3.ZERO
		enemy.move_and_slide()
		return

	var next_position : Vector3 = navigation_agent.get_next_path_position()
	var direction : Vector3 = enemy.global_position.direction_to(next_position)
	direction.y = 0
	direction = direction.normalized()
	var target_velocity : Vector3 = direction * speed



	enemy.velocity.x = move_toward(
		enemy.velocity.x,
		target_velocity.x,
		acceleration * delta
	)

	enemy.velocity.z = move_toward(
		enemy.velocity.z,
		target_velocity.z,
		acceleration * delta
	)

	if direction.length() > 0:
		enemy.rotation.y = atan2(direction.x, direction.z) - deg_to_rad(90)
	
	# Apply movement
	enemy.move_and_slide()

func update(_delta: float) -> void:
	pass
