extends CanvasLayer
class_name HUD

@export var player : Player 
@export var health_bar : ProgressBar
@export var stamina_bar : ProgressBar
@export var mana_bar : ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = player.health_component.max_health
	stamina_bar.value = player.stamina_component.max_stamina
	mana_bar.value = player.mana_component.max_mana
	
	player.health_component.health_changed.connect(update_health)
	player.stamina_component.stamina_changed.connect(update_stamina)
	player.mana_component.mana_changed.connect(update_mana)

func update_health(_amount_changed: int, new_health: int) -> void:
	health_bar.value = new_health
	pass
func update_stamina(_amount_changed: int, new_stamia: int) -> void:
	stamina_bar.value = new_stamia
	pass
func update_mana(_amount_changed: int, new_mana: int) -> void:
	mana_bar.value = new_mana
	pass
