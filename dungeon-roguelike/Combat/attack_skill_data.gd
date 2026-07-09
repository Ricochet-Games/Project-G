extends Resource
class_name AttackSkillData

@export var skill_name : String

@export var mana_cost : float = 20

@export var stamina_cost : float = 20

@export var windup : float = 0.1

@export var active_time : float = 0.10

@export var recovery : float = 0.2

@export var damage_type : WeaponData.DamageType

@export var damage : float = 40

@export var hitbox_scenes : Array[PackedScene]

@export var effects : Array[SkillEffect]
