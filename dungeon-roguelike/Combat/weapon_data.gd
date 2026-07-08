extends Resource
class_name WeaponData

@export var weapon_name : String

@export var weapon_type : WeaponType

@export var attacks : Array[AttackData]

@export var offhand_attacks : Array[AttackData]

@export var skills : Array[AttackSkill]

@export var attack_speed : float = 1.0

@export var attack_range : float = 1.5

@export var can_two_hand : bool = true

@export var can_main_hand : bool = true

@export var can_off_hand : bool = true

enum WeaponType
{
	SWORD,
	CLAYMORE,
	GREATSWORD,
	POLEARMS,
	STAVES,
	MACES,
	DAGGER,
	BOWS,
	CROSSBOWS,
	SHIELDS,
	SCROLLS
}

enum DamageType
{
	BLUNT,
	SLASH,
	PIERCE,
}
