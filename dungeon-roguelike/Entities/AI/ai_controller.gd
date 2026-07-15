extends Node
class_name AIController

@export var enemy: EnemyBase

@export var blackboard: Blackboard
@export var brain: Brain

## Needs to be multiple state machines
@export var state_machine: StateMachine

var context: AIContext

func _ready() -> void:
	initialize_context()
	initialize_systems()
	initialize_subscriptions()

func initialize_context() -> void:
	context = AIContext.new(enemy)

func initialize_systems() -> void:
	if brain:
		brain.initialize(context, blackboard)
	
	if state_machine:
		state_machine.initialize(context, blackboard)

func initialize_subscriptions() -> void:
	if context.vision:
		context.vision.found_target.connect(blackboard.set_target)
		context.vision.lost_target.connect(blackboard.set_target)


func _physics_process(delta: float) -> void:
	## Update each child in order to prevent race conditions
	update_blackboard(delta)
	update_brain(delta)
	update_state_machine(delta)

func update_blackboard(delta: float) -> void:
	if blackboard:
		blackboard.update(delta)

func update_brain(delta: float) -> void:
	if brain:
		brain.update(delta)

func update_state_machine(delta: float) -> void:
	if state_machine:
		state_machine.update(delta)
