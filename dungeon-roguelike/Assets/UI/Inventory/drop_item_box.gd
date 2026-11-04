extends TextureRect


func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton or not event.pressed:
		return
		
	if event.button_index == MOUSE_BUTTON_LEFT:
		print("L")
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		print("R")
	
