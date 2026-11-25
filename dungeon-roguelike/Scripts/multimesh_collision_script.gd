extends MultiMeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().physics_frame
	check_area()

func check_area() -> void:
	var space_state := get_world_3d().direct_space_state
	
	# Configuring shape
	var shape := SphereShape3D.new()
	shape.radius = .01
	
	# Query variable parameters
	var query := PhysicsShapeQueryParameters3D.new()
	query.shape = shape
	query.collide_with_bodies = true
	
	for i in multimesh.instance_count:
		var local_transform := multimesh.get_instance_transform(i)
		var world_transform := global_transform * local_transform
		query.transform = Transform3D(Basis(), world_transform.origin)
		query.collide_with_areas = false
		query.collision_mask = 2
		
		var hits := space_state.intersect_shape(query, 1)
		if hits.size() > 0:
			local_transform.origin.y = -1000.0
			multimesh.set_instance_transform(i, local_transform)
	
