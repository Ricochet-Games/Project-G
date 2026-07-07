extends Node
class_name StaminaComponent

signal used_stamina(amount: int, new_stamina: int)
signal gained_stamina(amount: int, new_stamina: int)
signal stamina_changed(amount: int)
signal out_of_stamina


@export var max_stamina : int = 100
@export var current_stamina: int = 100
