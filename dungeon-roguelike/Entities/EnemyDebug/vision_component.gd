extends Node3D
class_name VisionComponent

signal found_target(target: Node3D)
signal lost_target(target: Node3D)

@export var timer: Timer
@export var vision_area: Area3D
@export var ray_cast_3d: RayCast3D

var has_target : bool = false
var current_target : Node3D

var accetable_targets : Array[Node3D]

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	
func _on_timer_timeout() -> void:
	var overlaps : Array[Node3D] = vision_area.get_overlapping_bodies()
	if overlaps.size() <= 0:
		lost_target.emit(null)
		return
	
	var target_in_range : bool = false
	for overlap in overlaps:
		if overlap is not Player:
			continue
		
		target_in_range = true
		var local_target : Vector3 = ray_cast_3d.to_local(overlap.global_position)
		ray_cast_3d.target_position = local_target
		ray_cast_3d.force_raycast_update()
		
		if not ray_cast_3d.is_colliding():
			lost_target.emit(null)
			continue
		
		if ray_cast_3d.get_collider() == overlap:
			if has_target == false:
				current_target = overlap
				found_target.emit(current_target)
				
			has_target = true
		else:
			print("LOST")
			if has_target:
				lost_target.emit(null)
				current_target = null
			has_target = false
	
	if not target_in_range:
		if has_target:
			lost_target.emit(null)
			has_target = false
