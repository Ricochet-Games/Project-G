extends Node

const PLAYER = preload("uid://dskimq7aam0br")
const CAM_RIG = preload("uid://c42wahi6383ju")

var enet_peer := ENetMultiplayerPeer.new()

var PORT = 9999
var IP_ADRESS = '127.0.0.1'
var is_server: bool = false

func _ready():
	if get_tree().current_scene.name == "test_scene":
		if OS.has_feature('server'):
			Network.start_server()
			add_player(multiplayer.get_unique_id())
		else:
			get_tree().quit()

func start_server():
	is_server = true;
	enet_peer.create_server(PORT)
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(remove_player)
	
	multiplayer.multiplayer_peer = enet_peer

func join_server():
	if not is_server:
		enet_peer.create_client(IP_ADRESS, PORT)
		multiplayer.peer_connected.connect(add_player)
		multiplayer.peer_disconnected.connect(remove_player)
		
	elif is_server:
		add_player(multiplayer.get_unique_id())
		
	multiplayer.connected_to_server.connect(on_connected_to_server)
	multiplayer.multiplayer_peer = enet_peer
	
	

func on_connected_to_server():
	add_player(multiplayer.get_unique_id())
	
func add_player(peer_id: int):
	if peer_id == 1:
		print("e")
	
	var new_player = PLAYER.instantiate()
	var player_cam = CAM_RIG.instantiate()
	new_player.name = str(peer_id)
	player_cam.name = str(peer_id)+ "_cam"
	get_tree().current_scene.add_child(new_player, true)

	if get_tree().current_scene.name == "test_scene":
		get_tree().get_root().get_node("test_scene/SubViewportContainer/SubViewport").add_child(player_cam, true)
	else:
		get_tree().get_root().get_node("Main/test_scene/SubViewportContainer/SubViewport").add_child(player_cam, true)

	player_cam.target = new_player

func remove_player(peer_id):
	if peer_id == 1:
		leave_server()
	
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	var player_to_remove = players.find_custom(func(item): return item.name == str(peer_id))
	if player_to_remove != -1:
		players[player_to_remove].queue_free()
	
func leave_server():
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = null
	clean_up_signals()
	get_tree().quit()
	
func clean_up_signals():
	multiplayer.peer_connected.disconnect(add_player)
	multiplayer.peer_disconnected.disconnect(remove_player)
	multiplayer.connected_to_server.disconnect(on_connected_to_server)
