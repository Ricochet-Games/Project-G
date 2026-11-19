class_name AugmentResource
extends Resource

@export var name : String = ""
@export var texture : Texture2D

enum type { None, Augment, Element }
@export var slot_type := type.None

func on_spawn(_proj: SpellProjectile) -> void: pass
func on_physics_tick(_proj: SpellProjectile) -> void: pass
func on_hit(_proj: SpellProjectile) -> void: pass
func on_expire(_proj: SpellProjectile) -> void: pass
