extends AIState
class_name AttackState


func enter() -> void:	
	blackboard.is_attacking = true
	context.attack.attack()
	super()

func update(delta: float) -> void:
	if blackboard.is_in_attack_range():
		pass
	else :
		report("out_of_attack_range")

func exit() -> void:
	blackboard.is_attacking = false
	super()
