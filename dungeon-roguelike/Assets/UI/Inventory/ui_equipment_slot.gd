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
	equip_weapon(item)
func place_stack() -> void:
	var item : InventoryItem = inventory_ui.mouse_container.item
	if not item is InventoryEquipment:
		return
	if not equipment_type == item.equipment_data.equipment_type:
		return
	super()
	equip_weapon(item)

func pick_up_stack() -> void:
	super()
	clear_weapon()


func equip_weapon(item: InventoryEquipment) -> void:
	inventory_ui.player.equip_weapon(item)
	
func clear_weapon() -> void:
	inventory_ui.player.clear_weapon()
