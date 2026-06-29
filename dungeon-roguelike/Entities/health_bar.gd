extends ProgressBar

@export var health_component: HealthComponent

func _ready()  -> void:
	max_value = health_component.max_health
	value = health_component.current_health

	health_component.damaged.connect(_on_damaged)

func _on_damaged(_current: int, new_health: int) -> void:
	value = new_health
