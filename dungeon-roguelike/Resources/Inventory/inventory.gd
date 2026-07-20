extends Resource
class_name Inv

signal update

@export var slots: Array[InvSlot]

func insert(item: InvItem) -> void:
	var itemslots := slots.filter(func(slot: Variant) -> bool: return slot.item == item) # if there's already a slot
	if !itemslots.is_empty():
		itemslots[0].amount += 1
	else: # if the slot is empty
		var emptyslots := slots.filter(func(slot: Variant) -> bool: return slot.item == null)
		if !emptyslots.is_empty():
			emptyslots[0].item = item
			emptyslots[0].amount = 1
	update.emit()
