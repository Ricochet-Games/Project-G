# Goes on the player, creates the projectiles for spells
extends Node3D

@export var projectile_scene: PackedScene

func _input(event: Variant) -> void:
	if event.is_action_pressed("attack"):
		cast()

func cast() -> void:
	var projectile := projectile_scene.instantiate()
	var direction: Vector3
	
	# change this direction variable based on how we're handling the way the player is facing
	direction = -get_global_transform().basis.z
	
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	
	projectile.shoot(direction)
