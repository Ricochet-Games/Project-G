extends Area3D

func _on_body_entered(body: Variant)  -> void:
	if body.has_method("request_damage"):
		body.request_damage(10)
