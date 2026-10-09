extends Node
class_name Inventory

signal update

@export var slots: Array[InventorySlot]
@export var inv_size : int

func _ready() -> void:
	while slots.size() < inv_size:
		slots.append(InventorySlot.new())

func insert(item: InventoryItem) -> void:   
	var itemslots := slots.filter(func(slot: Variant) -> bool: return slot.item == item) # if there's already a slot
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else: # if the slot is empty
		var emptyslots := slots.filter(func(slot: Variant) -> bool: return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()

func add_item_to_slot(slot_index: int, inv_item: InventoryItem, amount: int) -> void:
	slots[slot_index].item = inv_item
	slots[slot_index].amount = amount
	

	
	#slots[slot_index].item = item
	#slots[slot_index].amount = amount
	pass

func swap_items(dragged_panel: Panel, dropped_panel: Panel) -> void:
	var dragged_inventory : Inventory =  dragged_panel.inventory
	var dropped_inventory : Inventory =  dropped_panel.inventory
	
	#var temp : Panel = to_invetory_slot DATA
	
	
	#dragged_slot.index
	
	var dragged_slot : InventorySlot = dragged_inventory.slots[dragged_panel.slot_index]
	var dragged_item : InventoryItem = dragged_inventory.slots[dragged_panel.slot_index].item
	var dragged_amount : int = dragged_inventory.slots[dragged_panel.slot_index].amount
	
	var dropped_slot : InventorySlot = dropped_inventory.slots[dropped_panel.slot_index]
	var dropped_item : InventoryItem = dropped_inventory.slots[dropped_panel.slot_index].item
	var dropped_amount : int = dropped_inventory.slots[dropped_panel.slot_index].amount
	
	
	add_item_to_slot(dropped_panel.slot_index, dragged_item, dragged_amount)
	
	add_item_to_slot(dragged_panel.slot_index, dropped_item, dropped_amount)
	
	
	#otherinv.add_item_to_slot(to_invetory_slot)
	print(dragged_panel)
	print(dropped_panel)

	update.emit()
	pass
	
func remove_item(from_inventory_slot: Panel) -> void:
	slots[from_inventory_slot.index] = null
