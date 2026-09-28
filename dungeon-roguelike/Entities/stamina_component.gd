extends Node
class_name StaminaComponent

signal used_stamina(amount: int)
# signal gained_stamina(amount: int, new_stamina: int)
signal stamina_changed(amount: int, new_stamina: int)
signal out_of_stamina


@export var max_stamina : int = 100
@export var current_stamina: int = 100

@export var stamina_regen_amount: int = 5
@onready var stamina_regen_timer: Timer = $StaminaRegenTimer
@onready var stamina_regen_pause_timer: Timer = $StaminaRegenPauseTimer
@export var stamina_regen_pause_time : float = 1
@onready var player: Player = $".."
@export var attack_component : AttackComponent


func _ready() -> void:
	current_stamina = max_stamina
	attack_component.started_attack.connect(_on_staminia_used)
	player.blocked.connect(_on_staminia_used)
	stamina_regen_timer.timeout.connect(_regenerate_stamina)
	stamina_regen_pause_timer.timeout.connect(_start_stamina_regen)
	stamina_regen_pause_timer.wait_time = stamina_regen_pause_time

func _on_staminia_used(stamina_used: int, _mana_used: int) -> void:
	if stamina_used == 0:
		return
	
	stamina_regen_timer.stop()
	stamina_regen_pause_timer.start()
	
	current_stamina = max(current_stamina - stamina_used, 0)
	used_stamina.emit(stamina_used, current_stamina)
	stamina_changed.emit(stamina_used, current_stamina)
	
	if current_stamina <= 0:
		out_of_stamina.emit()

func _regenerate_stamina() -> void:
	if current_stamina < max_stamina:
		current_stamina = min(current_stamina + stamina_regen_amount, max_stamina)
		stamina_changed.emit(stamina_regen_amount, current_stamina)
		
func _start_stamina_regen() -> void:
	stamina_regen_timer.start()
