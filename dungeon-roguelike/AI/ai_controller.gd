extends Node
class_name AIController

@export var creature: CreatureBase

@export var blackboard: Blackboard
@export var brain: Brain

@export var state_machine: AIStateMachine

var context: AIContext

func _ready() -> void:
	initialize_context()
	initialize_systems()

func initialize_context() -> void:
	context = AIContext.new(creature)

func initialize_systems() -> void:
	if brain:
		brain.initialize(context, blackboard, state_machine)
	
	if state_machine:
		state_machine.initialize(context, blackboard)



func _physics_process(delta: float) -> void:
	## Update each child in order to prevent race conditions
	#update_blackboard(delta)
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
