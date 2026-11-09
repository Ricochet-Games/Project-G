extends Control
class_name AugmentUI

@export var cursor : CastingMouseContainer

var is_holding : bool = false
var origin_slot : AugmentSlotUI

func _ready() -> void:
	for slot in find_children("*", "AugmentSlotUI", true, false):
		slot.root = self

func pick_up(aug: AugmentResource, from_slot: AugmentSlotUI) -> void:
	is_holding = true
	origin_slot = from_slot
	cursor.set_item(aug)

func clear_held() -> void:
	is_holding = false
	origin_slot = null
	cursor.clear()

func release_held() -> void:
	if not is_holding:
		return
	if origin_slot:
		origin_slot.set_item(cursor.item)
	clear_held()
