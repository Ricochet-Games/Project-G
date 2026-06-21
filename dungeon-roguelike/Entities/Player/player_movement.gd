extends CharacterBody3D

@export var speed: float = 5.0

@export var player_rotation_speed: float = 0.1

@export var health_component: HealthComponent
	
func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		var target_rotation = atan2(direction.x, direction.z)
		rotation.y = target_rotation + deg_to_rad(-90)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
