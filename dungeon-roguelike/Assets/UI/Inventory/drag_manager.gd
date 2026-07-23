extends Node

var texture_data: Texture2D = null
var amount_data: int = 1

var preview_node: Control = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func pickup(data: Texture2D, preview: Control) -> void:
	texture_data = data
	preview_node = preview
	# add preview to follow mouse

func drop() -> Variant:
	var data = texture_data
	if preview_node:
		preview_node.queue_free()
	texture_data = null
	preview_node = null
	return data
