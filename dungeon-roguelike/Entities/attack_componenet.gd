extends Node3D
class_name AttackComponent

@export var weapon_handler : WeaponHandler
@export var stamina_component : StaminaComponent
@export var mana_component : ManaComponent
var combo := 0
var can_combo := false
@export var combo_timer : Timer

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

func attack(is_attack_skill : bool = false) -> void:
	if not attack_state == AttackStatus.IDLE:
		return

	var weapon : WeaponData = weapon_handler.get_weapon()

	if weapon == null:
		return
	
	if not is_attack_skill:
		if not can_combo:
			combo = 0
	
		if combo >= weapon.attacks.size():
			combo = 0

	var current_attack_data : Variant ## Attack Data or Attack Skill Data
	
	if is_attack_skill:
		## Need a way to select which attack skill in the future
		current_attack_data = weapon.attack_skills[0] 
	else:
		current_attack_data = weapon.attacks[combo]

	if stamina_component and stamina_component.current_stamina == 0:
		return
	if mana_component and mana_component.current_mana < current_attack_data.mana_cost:
		return
	
	perform_attack(current_attack_data)

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
		hitbox.damage_owner = attack_owner
	
