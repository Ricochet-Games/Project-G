extends InventorySlotUI
class_name EquipmentSlotUI

@export var equipment_type : EquipmentData.EquipmentType 
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var item : InventoryItem = inventory.get_item_at(data.slot_index).item
	if not item is InventoryEquipment:
		return
	
	if not equipment_type == item.equipment_data.equipment_type:
		return
	
	super(_at_position, data)
	print("SAME")
	
