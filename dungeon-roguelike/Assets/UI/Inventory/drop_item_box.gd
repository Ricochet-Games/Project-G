extends TextureRect

@export var inventory_ui : Control
@export var mouse_container: MouseContainer

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton or not event.pressed:
		return
	if not inventory_ui.is_holding_item:
			return
	
	if event.button_index == MOUSE_BUTTON_LEFT:
		inventory_ui.spawn_dropped_item(mouse_container.item, mouse_container.amount)
		inventory_ui.is_holding_item = false
		mouse_container.clear()
		
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		inventory_ui.spawn_dropped_item(mouse_container.item, 1)
		mouse_container.remove_item(1)
		if inventory_ui.mouse_container.amount == 0:
			inventory_ui.is_holding_item = false
			inventory_ui.mouse_container.clear()
