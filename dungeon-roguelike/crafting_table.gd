extends Area3D

func interact(player: Player) -> void:
	if player.inventory_ui.is_open:
		player.inventory_ui.close()
	else:
		player.inventory_ui.open_crafting_table()
