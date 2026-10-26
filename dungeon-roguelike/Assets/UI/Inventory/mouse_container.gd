extends Control
class_name MouseContainer

var item : InventoryItem
var amount : int

@onready var label: Label = $Label
@onready var sprite_2d: Sprite2D = $Sprite2D


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	pass

@warning_ignore("shadowed_variable")
func set_item(item: InventoryItem, amount: int)-> void:
	self.item = item
	self.amount = amount
	refresh() 


func clear() -> void:
	item = null
	amount = 0


func refresh() -> void:
	sprite_2d.texture = item.texture
	label.text = str(amount)
	pass
