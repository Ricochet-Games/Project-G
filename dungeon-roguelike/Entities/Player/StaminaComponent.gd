extends Node
class_name StaminaComponent

signal used_stamina(amount: int, new_health: int)
signal gained_stamina(amount: int, new_health: int)
# signal health_changed(amount: int)
signal out_of_stamina
# Called when the node enters the scene tree for the first time.
@export var max_stamina : int = 100
