extends Node
class_name AttackCompontent

@export var weapon_handler : WeaponHandler

var combo := 0
var can_combo := false
@export var combo_timer : Timer

@export var hitbox: Area3D

enum AttackState
{
	IDLE,
	WINDING_UP,
	ATTACKING,
	RECOVERING,
}

@export var attack_state : AttackState = AttackState.IDLE

func _ready() -> void:
	combo_timer.timeout.connect(on_combo_timer_timeout)

func on_combo_timer_timeout() -> void:
	if not attack_state == AttackState.IDLE:
		return
	
	combo = 0
	can_combo = false

func attack() -> void:
	if not attack_state == AttackState.IDLE:
		return

	var weapon : WeaponData = weapon_handler.get_weapon()

	if weapon == null:
		return
		
	if not can_combo:
		combo = 0
	
	if combo >= weapon.attacks.size():
		combo = 0

	var current_attack : AttackData = weapon.attacks[combo]

	perform_attack(current_attack)

	

@warning_ignore("shadowed_variable")
func perform_attack(attack : AttackData) -> void:
	
	hitbox.damage = attack.damage
	print(attack.resource_path + "  " + var_to_str(combo))
	can_combo = false
	
	attack_state = AttackState.WINDING_UP
	await get_tree().create_timer(attack.windup).timeout
	
	
	hitbox.get_child(0).get_child(0).visible = true
	hitbox.monitoring = true
	
	attack_state = AttackState.ATTACKING
	await get_tree().create_timer(attack.active_time).timeout
	
	hitbox.get_child(0).get_child(0).visible = false
	hitbox.monitoring = false

	
	attack_state = AttackState.RECOVERING
	await get_tree().create_timer(attack.recovery).timeout
	
	attack_state = AttackState.IDLE
	can_combo = true
	combo_timer.start(attack.combo_window)
	combo += 1
