extends Node
class_name Inventory

signal update

@export var slots: Array[InventorySlot]
@export var inv_size : int

func _ready() -> void:
	while slots.size() < inv_size:
		slots.append(InventorySlot.new())

func insert(item: InventoryItem, amount: int) -> void:   
	var itemslots := slots.filter(func(slot: Variant) -> bool: return slot.item == item and slot.amount < item.max_stack_size) # if there's already a slot
	if !itemslots.is_empty():
		for itemslot : InventorySlot in itemslots:
			var can_add : int = item.max_stack_size - itemslot.amount 
			if amount <= can_add :
				itemslot.amount += amount
				amount = 0 # Added all that were picked up
			else:
				amount -= can_add # Calculate remainder for overflow
				itemslot.amount += can_add
				
	if amount <= 0: # Early out if there is no items to add to an empty slot
		update.emit()
		return
	
	var emptyslots := slots.filter(func(slot: Variant) -> bool: return slot.item == null)
	if !emptyslots.is_empty():
		for itemslot : InventorySlot in emptyslots:
			if amount > item.max_stack_size :
				itemslot.item = item
				itemslot.amount = item.max_stack_size # Fill up empty slot
				amount -= item.max_stack_size 
			else:
				itemslot.item = item
				itemslot.amount = amount # Add remainder to slot
				amount = 0

			if amount <= 0: # Early out if there is no items to add to an empty slot
				break

	update.emit()

func set_item_at_slot(slot_index: int, inv_item: InventoryItem, amount: int) -> void:
	slots[slot_index].item = inv_item
	slots[slot_index].amount = amount
	update.emit()

func swap_items(dragged_panel: InventorySlotUI, dropped_panel: InventorySlotUI) -> void:
	var dragged_inventory : Inventory =  dragged_panel.inventory
	var dropped_inventory : Inventory =  dropped_panel.inventory
	
	var _dragged_slot : InventorySlot = dragged_inventory.slots[dragged_panel.slot_index]
	var dragged_item : InventoryItem = dragged_inventory.slots[dragged_panel.slot_index].item
	var dragged_amount : int = dragged_inventory.slots[dragged_panel.slot_index].amount
	
	var _dropped_slot : InventorySlot = dropped_inventory.slots[dropped_panel.slot_index]
	var dropped_item : InventoryItem = dropped_inventory.slots[dropped_panel.slot_index].item
	var dropped_amount : int = dropped_inventory.slots[dropped_panel.slot_index].amount
	
	dropped_inventory.set_item_at_slot(dropped_panel.slot_index, dragged_item, dragged_amount)
	dragged_inventory.set_item_at_slot(dragged_panel.slot_index, dropped_item, dropped_amount)
	
	update.emit()
	pass

func get_item_at(slot_index: int) -> InventorySlot:
	
	return slots[slot_index]

func add_item_to_slot(slot_index: int, amount: int) -> void:
	slots[slot_index].amount += amount
	update.emit()

func remove_item_from_slot(slot_index: int, amount: int) -> void:
	slots[slot_index].amount -= amount
	update.emit()

func clear_slot(slot_index: int) -> void:
	slots[slot_index].clear()
	update.emit()
	pass
