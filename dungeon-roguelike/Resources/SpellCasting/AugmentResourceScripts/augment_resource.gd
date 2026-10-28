class_name AugmentResource
extends Resource

@export var name : String = ""
@export var texture : Texture2D

func on_spawn(_proj: SpellProjectile) -> void: pass
func on_physics_tick(_proj: SpellProjectile) -> void: pass
func on_hit(_proj: SpellProjectile) -> void: pass
func on_expire(_proj: SpellProjectile) -> void: pass
