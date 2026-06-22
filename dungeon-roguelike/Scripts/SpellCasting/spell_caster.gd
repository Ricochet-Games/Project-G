# Goes on the player, creates the projectiles for spells
extends Node

@export var projectile_scene: PackedScene

func cast() -> void:
	var projectile = projectile_scene.instantiate()
