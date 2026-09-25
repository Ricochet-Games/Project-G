extends AugmentResource

@export var delay: float = 1.5
@export var split_count: int = 2
@export var split_angle: float = 45.0

func on_spawn(proj: SpellProjectile) -> void:
	# Adjusting the direction of the original projectile
	
	
	# Creating the second projectile
	var projectile: SpellProjectile = proj.caster.projectile_scene.instantiate()
	projectile.caster = proj.caster
	for augment in proj.augments:
		projectile.augments.append(augment.duplicate())
	projectile.global_position = proj.global_position
	projectile.apply_impulse(proj.caster.direction * projectile.speed)
	projectile.caster.get_tree().current_scene.add_child(projectile)
