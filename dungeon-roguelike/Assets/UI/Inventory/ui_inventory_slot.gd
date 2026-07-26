extends Panel

@onready var item_visual: Sprite2D = $Control/ItemDisplay
@onready var amount_text: Label = $Control/Label
#var texture: Texture2D

func process() -> void:
	pass

func update(slot: InvSlot) -> void:
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

func _gui_input(_event: InputEvent) -> void:
	pass

#func _get_drag_data(_at_position: Vector2) -> Variant:
	#var wrapper : Control = Control.new()
	#wrapper.custom_minimum_size = texture.get_size()
	#
	#var prev: TextureRect = TextureRect.new()
	#prev.texture = texture
	#
	#wrapper.add_child(prev)
	#
	#set_drag_preview(wrapper)
	#
	#return self
