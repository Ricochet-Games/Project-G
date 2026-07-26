extends AIState
class_name AttackState


func enter() -> void:	
	blackboard.is_attacking = true
	print("attacked")
	context.attack.attack()
	super()

func update(delta: float) -> void:
	#if target == null:
		#report("hit_target")
#
	#elif false:
		#report("missed_target")
	super(delta)

func exit() -> void:
	blackboard.is_attacking = false
	super()
