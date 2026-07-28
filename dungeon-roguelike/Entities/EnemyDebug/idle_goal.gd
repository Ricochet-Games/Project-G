extends Goal
class_name IdleGoal

func evaluate() -> float:
	return 5 ## Change this from 5, this just forces idle but it should be gone / dynamic in some way

func enter() -> void:
	super()
	state_machine.change_state(&"IdleState")

func update(delta: float) -> void:
	super(delta)
