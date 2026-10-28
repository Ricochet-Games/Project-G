extends Control
class_name CastingMouseContainer

var augment : AugmentResource
var amount : int

@onready var label: Label = $Label
@onready var sprite_2d: Sprite2D = $Sprite2D


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	pass

@warning_ignore("shadowed_variable")
func set_augment(augment: AugmentResource, amount: int)-> void:
	self.augment = augment
	self.amount = amount
	refresh() 

func remove_augment(amount: int)-> void:
	self.amount -= amount
	
	if self.amount == 0:
		clear()
	else:
		refresh() 


func clear() -> void:
	augment = null
	amount = 0


func refresh() -> void:
	sprite_2d.texture = augment.texture
	label.text = str(amount)
	pass
