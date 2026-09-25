extends AugmentResource

var speed: float = 10.0

func on_spawn(proj: Projectile) -> void:
	print("did something on spawn")

func on_physics_tick(proj:Projectile) -> void:
	print("currently doing something")

func on_expire(proj: Projectile) -> void:
	print("expired")
