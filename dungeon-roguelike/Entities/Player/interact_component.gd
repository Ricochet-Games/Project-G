extends Area3D
class_name InteractComponent

var interactables: Array[Area3D] = []
var closest_interactable: Area3D = null
@onready var player: Player = $".."

func _process(_delta: float) -> void:
	calc_dist()

func interact() -> void:
	if closest_interactable == null:
		return
		
	if not closest_interactable.has_method("interact"):
		return
		

	closest_interactable.interact(player)
		
		
		


func _on_area_entered(area: Area3D) -> void:
	# Add object to the array if they enter the area
	if area.is_in_group("Interactable"):
		interactables.append(area)

func _on_area_exited(area: Area3D) -> void:
	# Remove object from array if they exit the area
	if area.is_in_group("Interactable"):
		interactables.erase(area)
		if closest_interactable == area:
			closest_interactable = null


func calc_dist() -> void:
	for interactable in interactables:
		# Checks if interactable is a valid object
		if not is_instance_valid(interactable):
			interactables.erase(interactable)
			continue
		
		# Check if closest item is not null, then compare distances and add to closest item if closer
		if closest_interactable != null:
			# does distance calc compared to closest item
			var closest_interactable_dist: float = global_position.distance_to(closest_interactable.global_position)
			if global_position.distance_to(interactable.global_position) < closest_interactable_dist:
				closest_interactable = interactable

		else:
			# Automatically adds item to closestItem if closestItem is null
			closest_interactable = interactable
