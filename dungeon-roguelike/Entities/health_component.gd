extends Node
class_name HealthComponent


signal damaged(amount: int)
signal healed(amount: int)
signal health_changed(amount: int)
signal died


@export var max_health : int = 100

@export var current_health : int

func _ready() -> void:
	current_health = max_health


func take_damage(amount: int) -> void:
	if current_health <= 0:
		return

	current_health = max(current_health - amount, 0)
	damaged.emit(amount)
	health_changed.emit(amount)
	
	if(current_health <= 0):
		died.emit()

func heal(amount: int) -> void:
	if(current_health <= 0):
		return
	
	current_health = min(current_health + amount, max_health)
	healed.emit(amount)
	health_changed.emit(current_health)
	
func is_alive() -> bool:
	return current_health > 0
