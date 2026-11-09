extends Panel
class_name InventorySlotUI

@export var inventory: Inventory

@export var slot_index: int

@onready var item_visual: Sprite2D = $Control/ItemDisplay
@onready var amount_text: Label = $Control/Label
#var texture: Texture2D
var inventory_ui : Control 

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

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

func has_item() -> bool:
	return inventory.slots[slot_index].has_item()

func _gui_input(event: InputEvent) -> void:
	
	if not event is InputEventMouseButton or not event.pressed:
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		if Input.is_key_pressed(KEY_SHIFT):
			shift_click()
			return
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
		if Input.is_key_pressed(KEY_SHIFT):
			shift_click()
			return
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
	inventory_ui.is_holding_item = true
	inventory_ui.mouse_container.show()
	inventory_ui.mouse_container.set_item(inventory.slots[slot_index].item, inventory.slots[slot_index].amount)
	
	inventory.clear_slot(slot_index)

func place_stack() -> void:
	inventory.set_item_at_slot(slot_index, inventory_ui.mouse_container.item, inventory_ui.mouse_container.amount)
	clear_mouse_container()
	
func place_one() -> void:
	if inventory.slots[slot_index].item and inventory.slots[slot_index].amount >= inventory.slots[slot_index].item.max_stack_size:
		return
	
	if inventory_ui.mouse_container.item == inventory.slots[slot_index].item:
		inventory.add_item_to_slot(slot_index, 1)
	else:
		inventory.set_item_at_slot(slot_index, inventory_ui.mouse_container.item, 1)
	
	inventory_ui.mouse_container.remove_item(1)
	
	if inventory_ui.mouse_container.amount == 0:
		clear_mouse_container()
	
func pick_up_half() -> void:
	var amount : int = inventory.slots[slot_index].amount
	@warning_ignore("integer_division")
	# Use integer division to remove decimal on 0.5s
	var half_stack: int = max(1, ((amount - 1) / 2) + 1)
	
	if amount <= 0:
		return
	
	inventory_ui.is_holding_item = true
	inventory_ui.mouse_container.show()
	inventory_ui.mouse_container.set_item(inventory.slots[slot_index].item, half_stack)
	
	inventory.remove_item_from_slot(slot_index, half_stack)
	
func fill_stack() -> void:
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
		clear_mouse_container()

func swap_stack() -> void:
	var item : InventoryItem = inventory_ui.mouse_container.item
	var amount : int = inventory_ui.mouse_container.amount	
	inventory_ui.mouse_container.set_item(inventory.slots[slot_index].item, inventory.slots[slot_index].amount)
	inventory.clear_slot(slot_index)
	inventory.set_item_at_slot(slot_index, item, amount)

func _on_mouse_entered() -> void:
	inventory_ui.is_hovering_item = true
	
	if inventory.slots[slot_index].item == null or inventory_ui.mouse_container.item:
		return
	
	inventory_ui.mouse_container.show_hover_name()
	inventory_ui.mouse_container.set_hover_name(inventory.slots[slot_index].item.name)

func _on_mouse_exited() -> void:
	inventory_ui.is_hovering_item = false
	inventory_ui.mouse_container.hide_hover_name()

func clear_mouse_container() -> void:
		inventory_ui.is_holding_item = false
		inventory_ui.mouse_container.clear()
		inventory_ui.mouse_container.show_hover_name()
		inventory_ui.mouse_container.set_hover_name(inventory.slots[slot_index].item.name)

func shift_click() -> void:
	var temp_item : InventoryItem = inventory.slots[slot_index].item
	if temp_item == null:
		return
	
	match inventory_ui.inventory_state:
		inventory_ui.InventoryState.CHEST:
			
			var to_inventory : Inventory 
			if inventory == inventory_ui.chest_inv:
				to_inventory = inventory_ui.inv
			else:
				to_inventory = inventory_ui.chest_inv
			
			var max_to_add : int = to_inventory.get_maxium_to_add(inventory.slots[slot_index].item)
			var amount_to_add : int = mini(inventory.slots[slot_index].amount, max_to_add)
			to_inventory.insert(inventory.slots[slot_index].item, amount_to_add)
			inventory.remove_item_from_slot(slot_index, amount_to_add)
			
		inventory_ui.InventoryState.MAIN:
			if inventory == inventory_ui.inv:
				if inventory.slots[slot_index].item is InventoryEquipment:
					var slot = inventory_ui.find_typed_slot(inventory.slots[slot_index].item.equipment_data.equipment_type)
					if !slot.has_item():
						inventory_ui.equipment_inv.set_item_at_slot(slot.slot_index, inventory.slots[slot_index].item, inventory.slots[slot_index].amount)
						inventory.clear_slot(slot_index)
			elif inventory == inventory_ui.equipment_inv:
				if inventory_ui.inv.can_add_item(inventory.slots[slot_index].item, inventory.slots[slot_index].amount):
					var temp_amount : int = inventory.slots[slot_index].amount
					inventory.clear_slot(slot_index)
					inventory_ui.inv.insert(temp_item, temp_amount)
					pass
	
	var temp_amount : int = inventory.slots[slot_index].amount
	inventory.clear_slot(slot_index)
	inventory.insert(temp_item, temp_amount)
	pass
