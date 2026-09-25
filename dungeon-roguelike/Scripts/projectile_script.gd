class_name Projectile
extends RigidBody3D

var augments: Array[AugmentResource]

var speed: float = 1
var duration: float = 1
@export var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = duration

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for augment in augments:
		augment.on_physics_tick(self)

func shoot(direction: Vector3) -> void:
	for augment in augments:
		augment.on_spawn(self)
	apply_impulse(direction * speed)


func _on_timer_timeout() -> void:
	for augment in augments:
		augment.on_expire(self)
	queue_free()
