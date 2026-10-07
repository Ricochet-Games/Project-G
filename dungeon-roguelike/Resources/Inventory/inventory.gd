extends Resource
class_name Inventory

signal update

@export var slots: Array[InventorySlot]

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

func add_item_to_slot(slot_index: int) -> void
	slots[]
	pass

func swap_items(from_inventory_slot, to_invetory_slot) -> void:
	#temp to_invetory_slot DATA
	
	#add_item_to_slot(from_inv_slot)
	#otherinv.add_item_to_slot(to_invetory_slot)
	print(from_inventory_slot)
	print(to_invetory_slot)

	update.emit()
	pass
	
func remove_item(from_inventory_slot: Panel) -> void:
	slots[from_inventory_slot.index] = null
