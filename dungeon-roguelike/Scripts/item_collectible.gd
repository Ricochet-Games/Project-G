extends Area3D

@export var itemData: InventoryItem
@export var amount : int = 1

func interact(player: Player) -> void:
	self.queue_free()
	player.collect(itemData, amount)
	pass
