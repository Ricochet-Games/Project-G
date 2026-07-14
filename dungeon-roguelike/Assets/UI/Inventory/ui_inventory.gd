extends TextureRect

var is_open := false

func _ready() -> void:
	close()
	
func _process(_delta: Variant) -> void:
	if Input.is_action_just_pressed("test_input"):
		if is_open:
			close()
		else:
			open()
	
func open() -> void:
	visible = true
	is_open = true

func close() -> void:
	visible = false
	is_open = false
