extends Node

@onready var wait_timer: Timer = $WaitTimer
@onready var active_timer: Timer = $ActiveTimer
@onready var hitbox: Hitbox = $Hitbox

@export var damage : float = 10

func _ready() -> void:
	hitbox.damage = damage
	wait_timer.timeout.connect(finished_wait)
	active_timer.timeout.connect(finished_attack)
	
	
func finished_wait() -> void:
	hitbox.enable_hitbox()
	active_timer.start()
	pass
	
func finished_attack() -> void:
	hitbox.disable_hitbox()
	wait_timer.start()
	pass
