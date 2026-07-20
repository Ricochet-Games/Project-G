extends Panel

@onready var item_visual: Sprite2D = $Control/ItemDisplay
@onready var amount_text: Label = $Control/Label

func update(slot: InvSlot) -> void:
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		amount_text.visible = true
		amount_text.text = str(slot.amount)
