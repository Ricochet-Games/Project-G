extends Area3D
@onready var inventory: Inventory = $Inventory


func interact(player: Player) -> void:
	player.inventory_ui.open_chest(inventory)

	## Subscribe the Chest UI to this inv
	## Refresh the UI
	
	#player.inv.
	
func _process(_delta: Variant) -> void:
	if Input.is_action_just_pressed("test_input"):
		
		print(inventory.slots.size())
		for slot in inventory.slots:
			#if slot.item == null
			#	return
			print(slot.item)
