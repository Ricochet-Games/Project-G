extends Area3D
@onready var inventory: Inventory = $Inventory


func interact(player: Player) -> void:
	if player.inventory_ui.is_open:
		player.inventory_ui.close()
	else:
		player.inventory_ui.open_chest(inventory)
