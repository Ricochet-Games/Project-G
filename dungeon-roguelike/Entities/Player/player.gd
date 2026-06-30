extends CharacterBody3D

@export var speed: float = 5.0

@export var player_rotation_speed: float = 0.1

@export var health_component: HealthComponent

var is_attacking : bool = false
@onready var hitbox: Area3D = $AttackPivot/Hitbox 
@onready var nameplate: Label3D = $Nameplate

const CAM_RIG = preload("uid://c42wahi6383ju")

func _enter_tree() -> void:
	set_multiplayer_authority(int(name))

func _ready() -> void:
	add_to_group("Player")
	nameplate.text = name
	
	if not is_multiplayer_authority():
		set_process(false)
		set_physics_process(false)
		return;
	
	var player_cam: Node = CAM_RIG.instantiate()
	player_cam.name = str(int(name))+ "_cam"
	player_cam.target = $"." 
	

	get_tree().current_scene.cameraHolder.add_child(player_cam, true)
	#player_cam.reparent(cameraHolder)

func _input(event: InputEvent)  -> void:
	if not is_multiplayer_authority():
		return
		
	if event.is_action_pressed("attack"):
		attack()

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
		var target_rotation: float = atan2(direction.x, direction.z)
		rotation.y = target_rotation + deg_to_rad(-90)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

func attack()  -> void:
	if is_attacking: 
		return  
	
	is_attacking = true
	hitbox.monitoring = true
	
	await get_tree().create_timer(0.15).timeout
	
	hitbox.monitoring = false
	is_attacking = false
