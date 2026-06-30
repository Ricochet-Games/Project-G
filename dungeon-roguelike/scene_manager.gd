extends Node
const DEBUG_SCENE = preload("uid://c4loax645yjo7")

var level_holder: Node
var current_level: Node

@onready var current_scene: Node = get_tree().current_scene

func _ready() -> void:
	CreateLevelHolder()

func LoadScene(scene_name: String) -> void:
	print("Loading Scene: " + scene_name)
	print("NOT IMPLEMENTED")

func LoadDebugScene() -> void:
	if get_child_count() != 0:
		remove_child(current_level)
	current_level = DEBUG_SCENE.instantiate()
	
	if level_holder == null:
		CreateLevelHolder()
	
	level_holder.add_child(current_level)

func CreateLevelHolder() -> void:
	level_holder = Node.new()
	level_holder.name = "Current Level"
	current_scene.add_child(level_holder)
