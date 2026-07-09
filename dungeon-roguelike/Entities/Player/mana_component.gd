extends Node
class_name ManaComponent

signal used_mana(amount: int, new_mana: int)
signal gained_mana(amount: int, new_mana: int)
signal mana_changed(amount: int, new_mana: int)
signal out_of_mana


@export var max_mana : int = 100
@export var current_mana: int = 100

@export var attack_component : AttackComponent


func _ready() -> void:
	current_mana = max_mana
	attack_component.attacked.connect(_on_attack)
	

func _on_attack(_stamina_used: int, mana_used: int) -> void:
	if mana_used == 0:
		return
		
	if current_mana <= 0:
		return
		
	current_mana = max(current_mana - mana_used, 0)
	used_mana.emit(mana_used, current_mana)
	mana_changed.emit(mana_used, current_mana)
	
	if current_mana <= 0:
		out_of_mana.emit()
