extends AugmentResource


@export var split_count: int = 2
@export var split_angle: float = 45.0

func on_spawn(proj: Projectile) -> void:
	print("did something on spawn")
