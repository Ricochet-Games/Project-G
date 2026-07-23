extends Area3D
class_name Hitbox

var damage : float
@export var meshes: Array[MeshInstance3D]
@export var damage_owner : Node3D
func _on_body_entered(body: Variant)  -> void:
	if body.has_method("set_most_recent_damage_source"):
		body.set_most_recent_damage_source(damage_owner)
	if body.has_method("request_damage"):
		body.request_damage(damage)

func enable_hitbox() -> void:
	for mesh in meshes:
		mesh.visible = true
	monitoring = true

func disable_hitbox() -> void:
	for mesh in meshes:
		mesh.visible = false
	monitoring = false
	
