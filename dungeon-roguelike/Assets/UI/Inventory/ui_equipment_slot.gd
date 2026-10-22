extends InventorySlotUI
class_name EquipmentSlotUI

@export var equipment_type : EquipmentData.EquipmentType 

func swap_stack()-> void:
	var item : InventoryItem = inventory_ui.mouse_container.item
	if not item is InventoryEquipment:
		return
	if not equipment_type == item.equipment_data.equipment_type:
		return
	super()
	
func place_stack() -> void:
	var item : InventoryItem = inventory_ui.mouse_container.item
	if not item is InventoryEquipment:
		return
	if not equipment_type == item.equipment_data.equipment_type:
		return
	super()
	
	
