extends AugmentResource

var speed: float = 5.0

func on_spawn(proj: SpellProjectile) -> void:
	proj.speed += speed
