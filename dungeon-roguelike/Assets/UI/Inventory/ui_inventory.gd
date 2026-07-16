extends TextureRect

@onready var inv: Inv = preload("res://Resources/Inventory/player_inventory.tres")
@onready var slots: Array = $GridContainer.get_children()

var is_open := false

func _ready() -> void:
	update_slots()
	close()

func update_slots() -> void:
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

func _process(_delta: Variant) -> void:
	if Input.is_action_just_pressed("test_input"):
		if is_open:
			close()
		else:
			open()
	
func open() -> void:
	visible = true
	is_open = true

func close() -> void:
	visible = false
	is_open = false
