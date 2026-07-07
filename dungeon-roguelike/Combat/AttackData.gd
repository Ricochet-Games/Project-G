extends Resource
class_name AttackData

@export var damage : float = 10

@export var mana_cost : float = 0

@export var stamina_cost : float = 5

@export var knockback : float = 0.0

@export var windup : float = 0.1

@export var active_time : float = 0.10

@export var recovery : float = 0.2

@export var damage_type : WeaponEnums.DamageType

@export var combo_window : float = 0.25

@export var hitbox_scenes : Array[PackedScene]
