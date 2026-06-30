extends Node

const PLAYER = preload("uid://dskimq7aam0br")


@export var cameraHolder: Node
@export var playerHolder: Node
@export var userInterface: Node


var players: Array[CharacterBody3D]

func _ready() -> void:
	Network.host_created.connect(on_host_created)
	

func on_host_created() -> void:
	spawn_player(multiplayer.get_unique_id())
	multiplayer.peer_connected.connect(spawn_player)
	

func spawn_player(peer_id: int) -> void:
	var new_player: CharacterBody3D = PLAYER.instantiate() as CharacterBody3D
	new_player.name = str(peer_id)
	add_child(new_player)

	initialize_player(new_player)


func initialize_player(player: CharacterBody3D) -> void:
	#player.position = $test_scene/SpawnPoint.position
	for other in players:
		player.add_collision_exception_with(other)
	players.append(player)

func _on_multiplayer_spawner_spawned(node: Node) -> void:
	if node is CharacterBody3D:
		initialize_player(node)	
