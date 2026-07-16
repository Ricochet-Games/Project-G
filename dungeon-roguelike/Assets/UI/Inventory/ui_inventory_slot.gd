extends Panel

@onready var item_visual: Sprite2D = $Control/ItemDisplay

func update(item: InvItem) -> void:
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture
