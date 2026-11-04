extends Node3D
class_name ItemPool
const ITEM_DROP = preload("uid://d0qn6a1or6y4k")


func spawn_item(location: Vector3, item: InventoryItem, amount: int) -> void:
	
	var new_item : ItemDrop = ITEM_DROP.instantiate()
	new_item.set_item(item, amount)
	add_child(new_item)
	new_item.global_position = location
