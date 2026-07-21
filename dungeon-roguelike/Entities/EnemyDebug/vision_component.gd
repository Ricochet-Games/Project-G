extends Node3D
class_name VisionComponent

signal found_target(target: Node3D)
signal lost_target(target: Node3D)

@export var timer: Timer
@export var vision_area: Area3D
@export var ray_cast_3d: RayCast3D

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout() -> void:
	var overlaps : Array[Node3D] = vision_area.get_overlapping_bodies()
	if overlaps.size() <= 0:
		lost_target.emit(null)
		return
	
	for overlap in overlaps:
		if not overlap is Player or overlap is CreatureBase:
			continue
		
		var local_target : Vector3 = ray_cast_3d.to_local(overlap.global_position)
		ray_cast_3d.target_position = local_target
		ray_cast_3d.force_raycast_update()
		
		#if not ray_cast_3d.is_colliding():
		#	lost_target.emit(null)
		#	continue
		
		if ray_cast_3d.get_collider() == overlap:
			found_target.emit(overlap)
		else:
			print("Raycast Failed to Hit Target")
			lost_target.emit(null)
