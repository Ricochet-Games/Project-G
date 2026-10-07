extends Panel

@export var inventory: Inventory

@export var slot_index: int

@onready var item_visual: Sprite2D = $Control/ItemDisplay
@onready var amount_text: Label = $Control/Label
#var texture: Texture2D
@onready var inventory_ui : Control = $"../../.."


func process() -> void:
	pass

func update(slot: InventorySlot) -> void:
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)
		#texture = item_visual.texture

func _get_drag_data(_at_position: Vector2) -> Dictionary:
	# Set visual previews
	# creat payload
	
	var wrapper : Control = Control.new()
	wrapper.custom_minimum_size = item_visual.texture.get_size()
	
	var preview : TextureRect = TextureRect.new()
	preview.texture = item_visual.texture
	preview.position = item_visual.texture.get_size() * 0.5
	wrapper.add_child(preview)

	set_drag_preview(wrapper)
	
	return {
		"inventory_slot": self,
		"slot_index": slot_index
	}

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is Dictionary \
		and data.has("inventory_slot") \
		and data.has("slot_index")
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var from_inventory_slot: Panel = data["inventory_slot"]
	var to_invetory_slot: Panel = self
	#var from_index: int = data["slot_index"]
	
	inventory_ui.inv.swap_items(from_inventory_slot, to_invetory_slot)
	#refresh()


#func _clear()
	#pass
	
