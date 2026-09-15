extends Node3D
class_name AttackComponent

@export var weapon_handler : WeaponHandler
@export var stamina_component : StaminaComponent
@export var mana_component : ManaComponent
var combo := 0
var can_combo := false
@export var combo_timer : Timer

enum AttackHand {MAIN, ALT, NULL}
@export var last_attack_hand : AttackHand
var last_weapon : WeaponData = null 


@export var attack_pivot : Node3D
@export var hitboxes: Array[Hitbox]
@export var attack_owner : Node3D

signal started_attack(stamina_used: int, mana_used: int) 

enum AttackStatus
{
	IDLE,
	WINDING_UP,
	ATTACKING,
	RECOVERING,
}

@export var attack_state : AttackStatus = AttackStatus.IDLE

func _ready() -> void:
	combo_timer.timeout.connect(on_combo_timer_timeout)

func on_combo_timer_timeout() -> void:
	if not attack_state == AttackStatus.IDLE:
		return
	
	combo = 0
	can_combo = false

func attack(attack_hand : AttackHand = AttackHand.NULL) -> void:
	var is_attack_skill : bool = false # Placeholder till we get attack skills going
	
	if not attack_state == AttackStatus.IDLE:
		return

	var weapon: WeaponData = (
	weapon_handler.get_weapon()
	if attack_hand == AttackHand.MAIN
	else weapon_handler.get_offhand_weapon()
)
	if weapon == null:
		return
		
	if weapon != last_weapon:
		combo = 0
	if attack_hand != last_attack_hand:
		combo = 0 
	
	
	
	if not is_attack_skill:
		if not can_combo:
			combo = 0
		
		if attack_hand == AttackHand.MAIN && combo >= weapon.attacks.size():
			combo = 0
		elif attack_hand == AttackHand.ALT && combo >= weapon.offhand_attacks.size():
			combo = 0
# need to check if current weapon is the same as last weapon
# need to check if current hand is same as the last hand 

# we can save these out at the end of the prior attack
# we need to check for any null cases on the first attack


	var current_attack_data : Variant ## Attack Data or Attack Skill Data
	
	if is_attack_skill:
		## Need a way to select which attack skill in the future
		current_attack_data = weapon.attack_skills[0] 
	elif attack_hand == AttackHand.ALT:
		if weapon.offhand_attacks.size() == 0:
			return
		 
		current_attack_data = weapon.offhand_attacks[combo]
	else:
		if weapon.attacks.size() == 0:
			return
		current_attack_data = weapon.attacks[combo]

	if stamina_component and stamina_component.current_stamina == 0:
		return
	if mana_component and mana_component.current_mana < current_attack_data.mana_cost:
		return
	
	perform_attack(current_attack_data)
	
	last_weapon = weapon
	last_attack_hand = attack_hand

@warning_ignore("shadowed_variable") 
func perform_attack(attack : Variant) -> void:
	##Attack is either AttackData or AttackSkillData
	create_hitboxes(attack.damage, attack.hitbox_scenes)

	if attack is AttackData:
		can_combo = false
	
	attack_state = AttackStatus.WINDING_UP
	started_attack.emit(attack.stamina_cost, attack.mana_cost)
	await get_tree().create_timer(attack.windup).timeout
	
	for hitbox in hitboxes:
		hitbox.enable_hitbox()
	
	attack_state = AttackStatus.ATTACKING
	await get_tree().create_timer(attack.active_time).timeout
	
	for hitbox in hitboxes:
		hitbox.disable_hitbox()
		hitbox.queue_free()
	
	hitboxes.clear()
	attack_state = AttackStatus.RECOVERING
	
	
	await get_tree().create_timer(attack.recovery).timeout
	
	
	
	attack_state = AttackStatus.IDLE
	
	if attack is AttackData:
		can_combo = true
		combo_timer.start(attack.combo_window)
		combo += 1

func create_hitboxes(damage : float, new_hitboxes :Array[PackedScene]) -> void:
	for packed_scene in new_hitboxes:
		var hitbox : Hitbox = packed_scene.instantiate()
		attack_pivot.add_child(hitbox)
		hitboxes.append(hitbox)
		hitbox.damage = damage
		#hitbox.damage_owner = attack_owner
	
