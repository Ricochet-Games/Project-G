extends Area3D
class_name ItemDrop

@export var itemData: InventoryItem
@export var amount : int = 1

func interact(player: Player) -> void:
	self.queue_free()
	player.collect(itemData, amount)
	pass

func set_item(item : InventoryItem, amount : int) -> void:
	itemData = item
	self.amount = amount
