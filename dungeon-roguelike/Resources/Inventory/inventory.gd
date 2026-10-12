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
				amount = 0
			else:
				amount -= can_add
				itemslot.amount += can_add
				

	if amount <= 0:
		update.emit()
		return
	var emptyslots := slots.filter(func(slot: Variant) -> bool: return slot.item == null)
	if !emptyslots.is_empty():
		emptyslots[0].item = item
		emptyslots[0].amount = amount
	update.emit()

func add_item_to_slot(slot_index: int, inv_item: InventoryItem, amount: int) -> void:
	slots[slot_index].item = inv_item
	slots[slot_index].amount = amount

func swap_items(dragged_panel: InventorySlotUI, dropped_panel: InventorySlotUI) -> void:
	var dragged_inventory : Inventory =  dragged_panel.inventory
	var dropped_inventory : Inventory =  dropped_panel.inventory
	
	var _dragged_slot : InventorySlot = dragged_inventory.slots[dragged_panel.slot_index]
	var dragged_item : InventoryItem = dragged_inventory.slots[dragged_panel.slot_index].item
	var dragged_amount : int = dragged_inventory.slots[dragged_panel.slot_index].amount
	
	var _dropped_slot : InventorySlot = dropped_inventory.slots[dropped_panel.slot_index]
	var dropped_item : InventoryItem = dropped_inventory.slots[dropped_panel.slot_index].item
	var dropped_amount : int = dropped_inventory.slots[dropped_panel.slot_index].amount
	
	add_item_to_slot(dropped_panel.slot_index, dragged_item, dragged_amount)
	add_item_to_slot(dragged_panel.slot_index, dropped_item, dropped_amount)
	
	update.emit()
	pass
