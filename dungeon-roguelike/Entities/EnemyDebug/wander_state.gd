extends AIState
class_name WanderState

@export var wander_radius := 10.0
@export var wait_time := 3.0

var target_position: Vector3
var wait_timer := 0.0

func enter() -> void:
	var wander_target : Vector3 = pick_wander_point()
	context.movement.move_to(wander_target)

func update(delta: float) -> void:
	if context.movement.has_reached_destination():
		wait_timer -= delta
		
		if wait_timer <= 0:
			var wander_target : Vector3 = pick_wander_point()
			context.movement.move_to(wander_target)



func pick_wander_point() -> Vector3:
	#for i in range(10): ## I wanna make 10 points and pick safest I think
	var offset : Vector3 = Vector3(
			randf_range(-wander_radius, wander_radius),
			0,
			randf_range(-wander_radius, wander_radius)
	)

	var point : Vector3 = context.creature.global_position + offset

		## We need to check if this isa safe spot to move to at somepoint
		
	wait_timer = wait_time
	return point
	#return Vector3.ZERO
		#if blackboard.is_position_safe(point):
			#target_position = point
