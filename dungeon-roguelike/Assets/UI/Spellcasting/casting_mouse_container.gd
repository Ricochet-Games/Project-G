extends Control
class_name CastingMouseContainer

var augment : AugmentResource

@onready var holder: Control = $Augment
@onready var icon: Sprite2D = $Augment/Icon

func _ready() -> void:
	holder.hide()

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()

func set_augment(new_augment: AugmentResource) -> void:
	augment = new_augment
	icon.texture = augment.texture
	holder.show()

func clear() -> void:
	augment = null
	holder.hide()
