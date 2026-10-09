extends Panel
class_name InventorySlotUI

@export var inventory: Inventory

@export var slot_index: int

@onready var item_visual: Sprite2D = $Control/ItemDisplay
@onready var amount_text: Label = $Control/Label
#var texture: Texture2D
@onready var inventory_ui : Control = $"../../.."


func process() -> void:
	pass

func init(inv: Inventory, index: int) -> void:
	inventory = inv
	slot_index = index
	pass

func update(slot: InventorySlot) -> void:
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)

func _get_drag_data(_at_position: Vector2) -> InventorySlotUI:
	if item_visual.texture == null:
		return
	
	var wrapper : Control = Control.new()
	wrapper.custom_minimum_size = item_visual.texture.get_size()
	
	var preview : TextureRect = TextureRect.new()
	preview.texture = item_visual.texture
	preview.position = item_visual.texture.get_size() * 0.5
	wrapper.add_child(preview)

	set_drag_preview(wrapper)
	
	return self
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is InventorySlotUI 

	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var from_inventory_slot: InventorySlotUI = data
	var to_invetory_slot: InventorySlotUI = self
	
	inventory_ui.inv.swap_items(from_inventory_slot, to_invetory_slot)
