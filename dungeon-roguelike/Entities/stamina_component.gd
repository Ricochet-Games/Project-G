extends Node
class_name StaminaComponent

signal used_stamina(amount: int, new_stamina: int)
signal gained_stamina(amount: int, new_stamina: int)
signal stamina_changed(amount: int, new_stamina: int)
signal out_of_stamina


@export var max_stamina : int = 100
@export var current_stamina: int = 100

@export var attack_component : AttackComponent


func _ready() -> void:
	current_stamina = max_stamina
	attack_component.started_attack.connect(_on_attack)
	

func _on_attack(stamina_used: int, _mana_used: int) -> void:
	if stamina_used == 0:
		return
		
	if current_stamina <= 0:
		return
	
	current_stamina = max(current_stamina - stamina_used, 0)
	used_stamina.emit(stamina_used, current_stamina)
	stamina_changed.emit(stamina_used, current_stamina)
	
	if current_stamina <= 0:
		out_of_stamina.emit()
