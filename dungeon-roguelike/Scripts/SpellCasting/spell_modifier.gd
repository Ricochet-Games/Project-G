extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _get_drag_data(_at_position: Vector2) -> Variant:
	var wrapper : Control = Control.new()
	wrapper.custom_minimum_size = texture.get_size()
	
	var prev : TextureRect = TextureRect.new()
	prev.texture = texture
	prev.position = -texture.get_size() * 0.5

	wrapper.add_child(prev)

	set_drag_preview(wrapper)
	
	return self
