extends Area3D
class_name ItemPickupComponent

var items: Array[Area3D] = []
var closest_item: Area3D = null
var itemData: InvItem = null

func _process(_delta: float) -> void:
	calc_dist()

func pickup_item() -> void:
	if closest_item:
		closest_item.queue_free()
		print("Picked up Item")

func _on_area_entered(area: Area3D) -> void:
	# Add object to the array if they enter the area
	if area.is_in_group("Item"):
		items.append(area)
		print("item entered, array size: ", items.size())


func _on_area_exited(area: Area3D) -> void:
	# Remove object from array if they exit the area
	if area.is_in_group("Item"):
		items.erase(area)
		if closest_item == area:
			closest_item = null
		print("item exited, array size: ", items.size())

func calc_dist() -> void:
	for item in items:
		# Checks if item is a valid object
		if not is_instance_valid(item):
			items.erase(item)
			continue
		
		# Check if closest item is not null, then compare distances and add to closest item if closer
		if closest_item != null:
			# does distance calc compared to closest item
			var closest_item_dist: float = global_position.distance_to(closest_item.global_position)
			if global_position.distance_to(item.global_position) < closest_item_dist:
				closest_item = item
				itemData = closest_item.itemData
				print("replaced closest_item")
		else:
			# Automatically adds item to closestItem if closestItem is null
			closest_item = item
			itemData = closest_item.itemData
			print("set initial item to closest_item")
