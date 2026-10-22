extends Panel
class_name InventorySlotUI

@export var inventory: Inventory

@export var slot_index: int

@onready var item_visual: Sprite2D = $Control/ItemDisplay
@onready var amount_text: Label = $Control/Label
#var texture: Texture2D
var inventory_ui : Control 


func process() -> void:
	pass

func init(inv_ui: Control, inv: Inventory, index: int) -> void:
	inventory_ui = inv_ui
	inventory = inv
	slot_index = index
	pass

func update(slot: InventorySlot) -> void:
	if !slot.item:
		item_visual.texture = null
		item_visual.visible = false
		amount_text.text = "0"
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.item.max_stack_size > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)
		
func _gui_input(event: InputEvent) -> void:
	
	if not event is InputEventMouseButton or not event.pressed:
		return
	
	if event.button_index == MOUSE_BUTTON_LEFT and not inventory_ui.is_holding_item:
		if not inventory.slots[slot_index].item:
			return
		
		inventory_ui.is_holding_item = true
		inventory_ui.mouse_container.show()
		
		inventory_ui.mouse_container.add_item(inventory.slots[slot_index].item, inventory.slots[slot_index].amount)
		inventory.clear_slot(slot_index)

		
	elif event.button_index == MOUSE_BUTTON_LEFT and inventory_ui.is_holding_item:
	
		
		
		if inventory.slots[slot_index].item:
			var item : InventoryItem = inventory_ui.mouse_container.item
			var amount : int = inventory_ui.mouse_container.amount	
			inventory_ui.mouse_container.add_item(inventory.slots[slot_index].item, inventory.slots[slot_index].amount)
			inventory.clear_slot(slot_index)
			inventory.add_item_to_slot(slot_index, item, amount)
		else:
			inventory_ui.is_holding_item = false
			inventory_ui.mouse_container.hide()
			inventory.add_item_to_slot(slot_index, inventory_ui.mouse_container.item, inventory_ui.mouse_container.amount)
			inventory_ui.mouse_container.clear()

	
