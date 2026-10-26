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
	if event.button_index == MOUSE_BUTTON_LEFT:
		if not inventory_ui.is_holding_item:
			if not inventory.slots[slot_index].item:
				return
			pick_up_stack()
		elif inventory_ui.is_holding_item:
			if inventory.slots[slot_index].item == inventory_ui.mouse_container.item:
				fill_stack()
			
			elif inventory.slots[slot_index].item:
				swap_stack()
			else:
				place_stack()
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		if not inventory_ui.is_holding_item:
			if not inventory.slots[slot_index].item:
				return
			pick_up_half()
		elif inventory_ui.is_holding_item:
			if inventory.slots[slot_index].item == inventory_ui.mouse_container.item or inventory.slots[slot_index].item == null:
				place_one()
			elif inventory.slots[slot_index].item:
				swap_stack()
			pass
	
func pick_up_stack() -> void:
	print("pick up stack")
	inventory_ui.is_holding_item = true
	inventory_ui.mouse_container.show()
		
	inventory_ui.mouse_container.set_item(inventory.slots[slot_index].item, inventory.slots[slot_index].amount)
	inventory.clear_slot(slot_index)

func place_stack() -> void:
	print("place stack")
	inventory_ui.is_holding_item = false
	inventory_ui.mouse_container.hide()
	inventory.set_item_at_slot(slot_index, inventory_ui.mouse_container.item, inventory_ui.mouse_container.amount)
	inventory_ui.mouse_container.clear()
	
func place_one() -> void:
	print("place one")
	
	if inventory_ui.mouse_container.item == inventory.slots[slot_index].item:
		inventory.add_item_to_slot(slot_index, 1)
	else:
		inventory.set_item_at_slot(slot_index, inventory_ui.mouse_container.item, 1)
	
	inventory_ui.mouse_container.remove_item(1)
	
	
	if inventory_ui.mouse_container.amount == 0:
		inventory_ui.is_holding_item = false
		inventory_ui.mouse_container.hide()
		inventory_ui.mouse_container.clear()
	
func pick_up_half() -> void:
	var amount : int = inventory.slots[slot_index].amount
	
	if amount <= 0:
		return
	
	print("pick up half")
	inventory_ui.is_holding_item = true
	inventory_ui.mouse_container.show()
	
	
	var half_stack: int = max(1, amount / 2)
	inventory_ui.mouse_container.set_item(inventory.slots[slot_index].item, half_stack)
	inventory.remove_item_from_slot(slot_index, half_stack)
	
func fill_stack() -> void:
	print("fill stack")
	var hold_amount: int = inventory_ui.mouse_container.amount
	var slot_amount: int = inventory.slots[slot_index].amount
	var slot_item: InventoryItem = inventory.slots[slot_index].item

	if not slot_item:
		return
	var can_add: int = slot_item.max_stack_size - slot_amount
	var amount_to_add: int = min(hold_amount, can_add)

	inventory.add_item_to_slot(slot_index, amount_to_add)
	inventory_ui.mouse_container.amount = hold_amount - amount_to_add

	if inventory_ui.mouse_container.amount == 0:
		inventory_ui.mouse_container.clear()
		inventory_ui.mouse_container.hide()
		inventory_ui.is_holding_item = false


func swap_stack() -> void:
	print("swap stack")
	var item : InventoryItem = inventory_ui.mouse_container.item
	var amount : int = inventory_ui.mouse_container.amount	
	inventory_ui.mouse_container.set_item(inventory.slots[slot_index].item, inventory.slots[slot_index].amount)
	inventory.clear_slot(slot_index)
	inventory.set_item_at_slot(slot_index, item, amount)
