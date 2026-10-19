extends Area3D
@onready var inventory: Inventory = $Inventory


func interact(player: Player) -> void:
	print(inventory)
