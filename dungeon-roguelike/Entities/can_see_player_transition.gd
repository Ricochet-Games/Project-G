extends Transition
class_name CanSeePlayerTransition

@export var vision_component: VisionComponent

func _ready() -> void:
	vision_component.found_target.connect(start_transiton)
	
