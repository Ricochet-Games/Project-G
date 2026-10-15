extends Panel
class_name DisplaySlotUI

@export var inventory: Inventory

@export var slot_index: int

@onready var item_visual: Sprite2D = $Control/ItemDisplay
@onready var amount_text: Label = $Control/Label
#var texture: Texture2D
var inventory_ui : Control 

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is InventorySlotUI 

	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	print("Dropped")
