extends Node
class_name WeaponHandler

@export var equipped_weapon : WeaponData

@export var equipped_offhand_weapon : WeaponData

func get_weapon() -> WeaponData:
	return equipped_weapon

func equip_weapon(new_weapon : WeaponData) -> void:
	equipped_weapon = new_weapon

func get_offhand_weapon() -> WeaponData:
	return equipped_weapon

func equip_offhand_weapon(new_weapon : WeaponData) -> void:
	equipped_weapon = new_weapon
