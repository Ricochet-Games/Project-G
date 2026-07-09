extends Node3D

@export var camera: Camera3D
@export var target: CharacterBody3D
@export var follow_speed: float = 5.0
@export var offset: Vector3 = Vector3(0, 0, 0)

func _ready() -> void:
	if Network.is_steam_initialized and multiplayer.has_multiplayer_peer() and not is_multiplayer_authority():
		camera.current = false
		set_process(false)
		set_physics_process(false)

func _physics_process(delta: float) -> void:
	if target == null:
		return

	var desired_position: Vector3 = target.global_position + offset

	global_position = global_position.lerp(
		desired_position,
		follow_speed * delta
		)
