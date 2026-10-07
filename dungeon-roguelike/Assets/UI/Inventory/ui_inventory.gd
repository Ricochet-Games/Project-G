extends Control

@onready var inv: Inventory = preload("res://Resources/Inventory/player_inventory.tres")
@onready var slots: Array = $BookTexture/GridContainer.get_children()

var is_open := false

func _ready() -> void:	 
	inv.update.connect(refresh)
	refresh()
	close()

func swap_item() -> void:
	#Take in From Item
	#Take in To Item
	#Swaps the data using Inv
	
	refresh()
	pass


func refresh() -> void:
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])

func _process(_delta: Variant) -> void:
	if Input.is_action_just_pressed("inventory"):
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
