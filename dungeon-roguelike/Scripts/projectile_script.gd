extends RigidBody3D

var speed: float = 1
var duration: float = 1
@export var timer: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = duration

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func shoot(direction: Vector3) -> void:
	apply_impulse(direction * speed)


func _on_timer_timeout() -> void:
	queue_free()
