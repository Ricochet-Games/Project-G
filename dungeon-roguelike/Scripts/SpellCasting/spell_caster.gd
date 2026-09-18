# Goes on the player, creates the projectiles for spells
extends Node3D

@export var projectile_scene: PackedScene
@export var spell_manager: Node

func _input(event: Variant) -> void:
	if event.is_action_pressed("attack_main"):
		cast()

func cast() -> void:
	var projectile := projectile_scene.instantiate()
	var direction: Vector3
	
	# change this direction variable based on how we're handling the way the player is facing
	direction = -get_global_transform().basis.z
	
	# Adds projectile to scene and sets the position of the projectile
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	
	# Calculates the cumulative stats of the spell
	spell_manager.calculate()
	
	projectile.speed = spell_manager.speed
	projectile.duration = spell_manager.duration
	
	# Fires the spell
	projectile.shoot(direction)
