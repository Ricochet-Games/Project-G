extends Control
class_name MouseContainer

var item : InventoryItem
var amount : int

@onready var item_holder: Control = $Item

@onready var label: Label = $Item/Label
@onready var sprite_2d: Sprite2D = $Item/Sprite2D

@onready var hover_name: Label = $"Hover Name"



func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()

@warning_ignore("shadowed_variable")
func set_item(item: InventoryItem, amount: int)-> void:
	item_holder.show()
	self.item = item
	self.amount = amount
	
	hide_hover_name()
	refresh() 
	
@warning_ignore("shadowed_variable")
func remove_item(amount: int)-> void:
	self.amount -= amount
	
	if self.amount == 0:
		clear()
	else:
		refresh() 
		

func clear() -> void:
	item_holder.hide()
	item = null
	amount = 0

func refresh() -> void:
	sprite_2d.texture = item.texture
	label.text = str(amount)
	pass

func show_hover_name() -> void:
	hover_name.show()

func hide_hover_name() -> void:
	hover_name.hide()

func set_hover_name(item_name: String) -> void:
	hover_name.text = item_name
