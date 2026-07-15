extends Node
class_name State

var enemy: EnemyBase
var state_machine: StateMachine

func enter() -> void:
	print("Entering " + name)
	pass

func exit() -> void:
	print("Exiting " + name)
	pass

func physics_update(_delta: float) -> void:
	pass

func update(_delta: float) -> void:
	pass
