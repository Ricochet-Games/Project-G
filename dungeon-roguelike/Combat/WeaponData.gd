extends Resource
class_name WeaponData

@export var weapon_name : String

@export var weapon_type : WeaponEnums.WeaponType

@export var attacks : Array[AttackData]

@export var offhand_attacks : Array[AttackData]

@export var skills : Array[AttackSkill]

@export var attack_speed : float = 1.0

@export var attack_range : float = 1.5
