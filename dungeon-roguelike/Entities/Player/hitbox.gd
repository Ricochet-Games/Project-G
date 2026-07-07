extends Area3D

var damage : float 

func _on_body_entered(body: Variant)  -> void:
	if body.has_method("request_damage"):
		body.request_damage(damage)
