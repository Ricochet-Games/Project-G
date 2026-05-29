# Goes on the player, creates the projectiles for spells
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		print("action happened")

func cast (behavior: SpellBehavior):
	# spell casting logic goes here
	# Apply spell_behavior and other data here to projectile
	pass
