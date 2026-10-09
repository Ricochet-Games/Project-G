extends AugmentResource

@export var delay : float = .25
@export var split_count : int = 2
@export var split_angle : float = 45.0
@export var projectile_scene : PackedScene = preload("res://Entities/projectile_base.tscn")

func on_spawn(proj: SpellProjectile) -> void:
	# Triggering the augment after a delay
	proj.duration = delay

func on_expire(proj: SpellProjectile) -> void:
	
	for i in split_count:
		# Spawning two projectiles
		var projectile := projectile_scene.instantiate()
		var split_angle_rad := deg_to_rad(split_angle)
		var base_dir : Vector3 = proj.caster.get_global_transform().basis.x
	
		projectile.caster = self
	
		# change this direction variable based on how we're handling the way the player is facing
		if i < 1:
			proj.caster.direction = base_dir.rotated(Vector3.UP, split_angle_rad)
		else:
			proj.caster.direction = base_dir.rotated(Vector3.UP, -split_angle_rad)
	
		# Adds projectile to scene and sets the position of the projectile
		proj.caster.get_tree().current_scene.add_child(projectile)
		projectile.global_position = proj.global_position
	
		# Grabs the augments from the spell manager
		for augment in proj.augments:
			if augment != self:
				projectile.augments.append(augment.duplicate())
	
		# Fires the spell
		projectile.shoot(proj.caster.direction)
