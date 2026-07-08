extends Area3D
class_name Hitbox

var damage : float 
@export var mesh_instance_3d: MeshInstance3D

func _on_body_entered(body: Variant)  -> void:
	if body.has_method("request_damage"):
		body.request_damage(damage)

func enable_hitbox() -> void:
	mesh_instance_3d.visible = true
	monitoring = true

func disable_hitbox() -> void:
	mesh_instance_3d.visible = false
	monitoring = false
	
