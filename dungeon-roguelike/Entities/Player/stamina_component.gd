extends Node
class_name StaminaComponent

signal used_stamina(amount: int, new_stamina: int)
signal gained_stamina(amount: int, new_stamina: int)
signal stamina_changed(amount: int)
signal out_of_stamina


@export var max_stamina : int = 100
@export var current_stamina: int = 100

@export var attack_component : AttackComponent


func _ready() -> void:
	current_stamina = max_stamina
	attack_component.attacked.connect(_on_attack)
	

func _on_attack(stamina_used: int) -> void:
	if current_stamina <= 0:
		return
		
	current_stamina = max(current_stamina - stamina_used, 0)
	
	if current_stamina <= 0:
		out_of_stamina.emit()
