extends AugmentResource

var speed: float = 10.0

func on_spawn(proj: SpellProjectile) -> void:
	print("did something on spawn")

func on_physics_tick(proj: SpellProjectile) -> void:
	print("currently doing something")

func on_expire(proj: SpellProjectile) -> void:
	print("expired")
