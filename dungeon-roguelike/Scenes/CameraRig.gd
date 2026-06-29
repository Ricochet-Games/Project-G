extends Node3D

@export var target: CharacterBody3D
@export var follow_speed: float = 5.0
@export var offset: Vector3 = Vector3(0, 0, 0)
@onready var camera: Camera3D = $Camera3D



func _enter_tree() -> void:
	set_multiplayer_authority(int(name))

func _ready() -> void:
	if not is_multiplayer_authority():
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
