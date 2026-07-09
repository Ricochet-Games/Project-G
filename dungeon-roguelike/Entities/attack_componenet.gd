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

signal started_attack(stamina_used: int, mana_used: int) 

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

	if stamina_component.current_stamina == 0:
		return
	if mana_component.current_mana < current_attack.mana_cost:
		return
		
	perform_attack(current_attack)

@warning_ignore("shadowed_variable")
func perform_attack(attack : AttackData) -> void:
	
	for packed_scene in attack.hitbox_scenes:
		var hitbox : Hitbox = packed_scene.instantiate()
		attack_pivot.add_child(hitbox)
		hitboxes.append(hitbox)
		hitbox.damage = attack.damage
	
	can_combo = false
	
	attack_state = AttackState.WINDING_UP
	started_attack.emit(attack.stamina_cost, attack.mana_cost)
	await get_tree().create_timer(attack.windup).timeout
	
	for hitbox in hitboxes:
		hitbox.enable_hitbox()
	
	attack_state = AttackState.ATTACKING
	await get_tree().create_timer(attack.active_time).timeout
	
	for hitbox in hitboxes:
		hitbox.disable_hitbox()
		hitbox.queue_free()
	
	hitboxes.clear()
	attack_state = AttackState.RECOVERING
	
	
	await get_tree().create_timer(attack.recovery).timeout
	
	attack_state = AttackState.IDLE
	can_combo = true
	combo_timer.start(attack.combo_window)
	combo += 1

func attack_skill() -> void:
	if not attack_state == AttackState.IDLE:
		return

	var weapon : WeaponData = weapon_handler.get_weapon()

	if weapon == null:
		return
	
	var current_attack_skill : AttackSkillData = weapon.attack_skills[0]

	if current_attack_skill.mana_cost > 0 and stamina_component.current_stamina == 0:
		return
	if mana_component.current_mana < current_attack_skill.mana_cost:
		return
		
	perform_attack_skill(current_attack_skill)
	
@warning_ignore("shadowed_variable")
func perform_attack_skill(attack_skill: AttackSkillData) -> void:
	for packed_scene in attack_skill.hitbox_scenes:
		var hitbox : Hitbox = packed_scene.instantiate()
		attack_pivot.add_child(hitbox)
		hitboxes.append(hitbox)
		hitbox.damage = attack_skill.damage
	
	attack_state = AttackState.WINDING_UP
	started_attack.emit(attack_skill.stamina_cost, attack_skill.mana_cost)
	await get_tree().create_timer(attack_skill.windup).timeout
	
	for hitbox in hitboxes:
		hitbox.enable_hitbox()
	
	attack_state = AttackState.ATTACKING
	await get_tree().create_timer(attack_skill.active_time).timeout
	
	for hitbox in hitboxes:
		hitbox.disable_hitbox()
		hitbox.queue_free()
	
	hitboxes.clear()
	attack_state = AttackState.RECOVERING
	
	
	await get_tree().create_timer(attack_skill.recovery).timeout
	
	attack_state = AttackState.IDLE
