extends Area3D
class_name ItemDrop

@export var itemData: InventoryItem
@export var amount : int = 1

func interact(player: Player) -> void:
	player.collect(itemData, amount, self)
	
@warning_ignore("shadowed_variable")
func set_item(item : InventoryItem, amount : int) -> void:
	itemData = item
	self.amount = amount

@warning_ignore("shadowed_variable")
func pick_up(amount: int) -> void:
	self.amount -= amount
	if self.amount <= 0:
		queue_free()
	pass
