extends Node
class_name HealthComponent


signal damaged(amount: int, source: Node3D)
signal healed(amount: int)
signal health_changed(amount: int, new_health: int)
signal died

var most_recent_damage_source: Node3D


@export var max_health : int = 100

@export var current_health: int = 100:
	set(value):
		var old : int = current_health
		current_health = clamp(value, 0, max_health)
		if old != current_health:
			health_changed.emit(current_health - old,current_health)
			if current_health < old:
				damaged.emit(old - current_health, most_recent_damage_source)
			elif current_health > old:
				healed.emit(current_health - old)
				
			if current_health <= 0 and is_alive():
				died.emit()

func set_most_recent_damage_source(source: Node3D) -> void:
	most_recent_damage_source = source

func _ready() -> void:
	if multiplayer.is_server():
		current_health = max_health

func request_damage(amount: int) -> void:
	if multiplayer.is_server():
		_apply_damage(amount)
	else:
		_rpc_damage.rpc_id(1, amount)

func request_heal(amount: int) -> void:
	if multiplayer.is_server():
		_apply_heal(amount)
	else:
		_rpc_heal.rpc_id(1, amount)

@rpc("any_peer", "reliable")
func _rpc_damage(amount: int) -> void:
	if not multiplayer.is_server():
		return
	_apply_damage(amount)

@rpc("any_peer", "reliable")
func _rpc_heal(amount: int) -> void:
	if not multiplayer.is_server():
		return
	_apply_heal(amount)

func _apply_damage(amount: int) -> void:
	if current_health <= 0:
		return

	current_health = max(current_health - amount, 0)
	damaged.emit(amount, current_health)
	# health_changed.emit(amount)
	
	if(current_health <= 0):
		died.emit()

func _apply_heal(amount: int) -> void:
	if(current_health <= 0):
		return
	
	current_health = min(current_health + amount, max_health)
	healed.emit(amount)
	# health_changed.emit(current_health)
	
func is_alive() -> bool:
	return current_health > 0
