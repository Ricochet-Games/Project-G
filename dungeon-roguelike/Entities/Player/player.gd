extends CharacterBody3D
class_name Player

@export var speed: float = 5.0
@export var player_rotation_speed: float = 0.1

@export var health_component: HealthComponent
@export var attack_compontent: AttackComponent 
@export var stamina_component: StaminaComponent
@export var mana_component: ManaComponent

@export var camera___sub_viewport_container: SubViewportContainer

@onready var nameplate: Label3D = $Nameplate

func _enter_tree() -> void:
	if Network.is_steam_initialized and multiplayer.has_multiplayer_peer():
		set_multiplayer_authority(int(name))


func _ready() -> void:
	nameplate.text = name
	
	if not is_multiplayer_authority():
		camera___sub_viewport_container.visible = false
	
	if Network.is_steam_initialized and multiplayer.has_multiplayer_peer() and not is_multiplayer_authority():
		set_process(false)
		set_physics_process(false)


func _input(event: InputEvent)  -> void:
	if not is_multiplayer_authority():
		return
		
	if event.is_action_pressed("attack"):
		attack_compontent.attack()
		
	if event.is_action_pressed("attack_skill"):
		attack_compontent.attack_skill()

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
