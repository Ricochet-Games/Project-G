extends CharacterBody3D

@export var speed: float = 5.0

@export var camera: Camera3D
@export var camera_follow_speed: float = 0.1

@export var player_rotation_speed: float = 0.1

func _physics_process(delta: float) -> void:

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	move_camera()


func move_camera():
	$Camera_Controller.position = lerp($Camera_Controller.position, position, camera_follow_speed)
