extends Node
class_name ManaComponent

signal used_mana(amount: int, new_mana: int)
signal gained_mana(amount: int, new_mana: int)
signal mana_changed(amount: int)
signal out_of_mana


@export var max_mana : int = 100
@export var current_mana: int = 100
