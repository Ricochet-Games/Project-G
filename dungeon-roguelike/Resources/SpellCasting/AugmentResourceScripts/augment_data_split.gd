extends AugmentResource

@export var delay: float = 1.5
@export var split_count: int = 2
@export var split_angle: float = 45.0

func on_spawn(proj: SpellProjectile) -> void:
	print("did something on spawn")
