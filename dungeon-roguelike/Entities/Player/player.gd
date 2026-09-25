extends CharacterBody3D
class_name Player

@export var speed: float = 5.0
@export var player_rotation_speed: float = 0.1

@export var health_component: HealthComponent
@export var attack_compontent: AttackComponent 
@export var stamina_component: StaminaComponent
@export var mana_component: ManaComponent
@export var itempickup_component: ItemPickupComponent

@export var sub_viewport_container: SubViewportContainer

@export var inv: Inv

@onready var nameplate: Label3D = $Nameplate

@export var state : PlayerState = PlayerState.IDLE 
	
@export var camera : Camera3D

enum PlayerState
{
	IDLE,
	WALKING,
	SPRINTING,
	ATTACKING,
	BLOCKING,
}


func _enter_tree() -> void:
	if Network.is_steam_initialized and multiplayer.has_multiplayer_peer():
		set_multiplayer_authority(int(name))
	
	

func _ready() -> void:
	nameplate.text = name
	GameManager.spawned_player.emit(self)
	
	if not is_multiplayer_authority():
		sub_viewport_container.visible = false
	
	if Network.is_steam_initialized and multiplayer.has_multiplayer_peer() and not is_multiplayer_authority():
		set_process(false)
		set_physics_process(false)


func _input(event: InputEvent)  -> void:
	if not is_multiplayer_authority():
		return
		
	if event.is_action_pressed("attack_main"):
		attack_compontent.attack(attack_compontent.AttackHand.MAIN)
		
	if event.is_action_pressed("attack_alt"):
		attack_compontent.attack(attack_compontent.AttackHand.ALT)
	if event.is_action_pressed("block"):
		attack_compontent.block()

	if event.is_action_pressed("item_pickup"):
		collect(itempickup_component.itemData)
		itempickup_component.pickup_item()
		
	if event.is_action_pressed("toggle_camera"):
		sub_viewport_container.visible = !sub_viewport_container.visible
	
	

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
		#var target_rotation: float = atan2(direction.x, direction.z)
		#rotation.y = target_rotation + deg_to_rad(-90)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	look_at_cursor()
	move_and_slide()

func look_at_cursor() -> void:
	var target_plane : Plane =  Plane(Vector3.UP, global_position.y)
	var ray_legth : float = 2000
	var mouse_position : Vector2 = get_viewport().get_mouse_position() / sub_viewport_container.stretch_shrink
	
	var ray_start : Vector3 = camera.project_ray_origin(mouse_position)
	var ray_direction : Vector3 = ray_start + camera.project_ray_normal(mouse_position) * ray_legth
	var cursor_world_position : Variant = target_plane.intersects_ray(ray_start, ray_direction)
	if cursor_world_position:
		var player_pos : Vector3 = self.global_position
		player_pos.y = 0
		var delta_pos : Vector3 = (player_pos - cursor_world_position)
		self.rotation.y = atan2(delta_pos.x, delta_pos.z)  + PI / 2.0

func request_damage(amount: int) -> void:
	health_component.request_damage(amount)

func collect(item: Variant) -> void:
	inv.insert(item)
