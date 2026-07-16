extends Panel

@onready var item_visual: Sprite2D = $Control/ItemDisplay

func update(slot: InvSlot) -> void:
	if !slot.item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
