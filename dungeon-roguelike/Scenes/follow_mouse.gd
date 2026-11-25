extends Node3D

@export var player: Player
@export var height_offset: float = 0.0
@export var mouse_y_offset: float = 30.0

var camera: Camera3D
var viewport_container: SubViewportContainer

func _ready() -> void:
	camera = player.camera
	viewport_container = camera.get_parent().get_parent().get_parent()

func _process(_delta: float) -> void:
	move_to_mose_position()
		
func move_to_mose_position() -> void:
	var mouse_pos := viewport_container.get_local_mouse_position()
	mouse_pos /= viewport_container.stretch_shrink

	# Offset mouse position in screen space
	mouse_pos.y += mouse_y_offset

	var ray_origin := camera.project_ray_origin(mouse_pos)
	var ray_direction := camera.project_ray_normal(mouse_pos)

	var ground := Plane(Vector3.UP, 0.0)
	var intersection: Variant = ground.intersects_ray(ray_origin, ray_direction)

	if intersection:
		global_position = intersection + Vector3.UP * height_offset
		
func place_in_world() -> void:
	##
	pass
