# Goes on the player, creates the projectiles for spells
extends Node3D

@export var projectile_scene: PackedScene
@export var spell_manager: Node

var augments: Array[AugmentResource] = []

func _input(event: Variant) -> void:
	if event.is_action_pressed("spell_cast"):
		if !spell_manager.visible:
			cast()

	if event.is_action_pressed("spell_menu"):
		open_menu()

func open_menu() -> void:
	spell_manager.visible = !spell_manager.visible

func cast() -> void:
	var projectile := projectile_scene.instantiate()
	var direction: Vector3
	
	# change this direction variable based on how we're handling the way the player is facing
	direction = -get_global_transform().basis.z
	
	# Adds projectile to scene and sets the position of the projectile
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = global_position
	
	# Grabs the augments from the spell manager
	augments.clear()
	augments = spell_manager.calculate()
	
	# Sends the augments to the projectile
	projectile.augments = augments
	
	#projectile.speed = spell_manager.speed
	#projectile.duration = spell_manager.duration
	
	# Fires the spell
	projectile.shoot(direction)
