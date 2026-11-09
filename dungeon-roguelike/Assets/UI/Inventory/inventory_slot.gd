extends Node
class_name InventorySlot

@export var item: InventoryItem
@export var amount: int

func clear() -> void:
	item = null
	amount = 0

func has_item() -> bool:
	return item != null
