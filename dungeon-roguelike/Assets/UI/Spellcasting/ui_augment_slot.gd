extends Panel
class_name AugmentSlotUI

@export var augment : AugmentResource:
	set(value):
		augment = value
		if is_node_ready():
			_refresh()

var root : AugmentUI

@onready var icon: Sprite2D = $Control/AugmentDisplay

func _ready() -> void:
	_refresh()

func set_augment(new_augment: AugmentResource) -> void:
	augment = new_augment

func _refresh() -> void:
	icon.visible = augment != null
	icon.texture = augment.texture if augment else null

func can_accept(incoming: AugmentResource) -> bool:
	return incoming != null

func _gui_input(event: InputEvent) -> void:
	if not event is InputEventMouseButton or not event.pressed:
		return
	if event.button_index != MOUSE_BUTTON_LEFT:
		return
	
	if not root.is_holding:
		if augment:
			root.pick_up(augment, self)
			set_augment(null)
	elif can_accept(root.cursor.augment):
		if augment:
			var old := augment
			set_augment(root.cursor.augment)
			root.cursor.set_augment(old)
		else:
			set_augment(root.cursor.augment)
			root.clear_held()
