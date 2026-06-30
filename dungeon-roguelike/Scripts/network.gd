extends Node

signal host_created()

var peer : SteamMultiplayerPeer

#var PORT: int = 9999
#var IP_ADRESS: String = '127.0.0.1'
#var is_server: bool = false

const LOBBY_TYPE := Steam.LobbyType.LOBBY_TYPE_FRIENDS_ONLY
const MAX_MEMBERS := 4

func _ready() -> void:
	Steam.initRelayNetworkAccess()
	Steam.lobby_created.connect(on_lobby_created)
	Steam.lobby_joined.connect(on_lobby_joined)
	Steam.join_requested.connect(on_lobby_requested)
	
	
	#if get_tree().current_scene.name == "test_scene":
		#if OS.has_feature('server'):
			#Network.start_server()
			#add_player(multiplayer.get_unique_id())
		#else:
			#get_tree().quit()

func _process(_delta: float) -> void:
	Steam.run_callbacks()

func host_lobby() -> void:
	Steam.createLobby(LOBBY_TYPE, MAX_MEMBERS)

@warning_ignore("shadowed_variable_base_class")
func on_lobby_created(connect: int, _lobby_id: int) -> void:
	if connect != Steam.RESULT_OK:
		return
		
	peer = SteamMultiplayerPeer.new()
	peer.server_relay = true
	peer.create_host()
	multiplayer.multiplayer_peer = peer
	host_created.emit()

func on_lobby_joined(lobby_id: int, _permissions: int, _locked: bool, response: int) -> void:
	if response != Steam.CHAT_ROOM_ENTER_RESPONSE_SUCCESS:
		return
	if Steam.getLobbyOwner(lobby_id) == Steam.getSteamID():
		return
			
	peer = SteamMultiplayerPeer.new()
	peer.server_relay = true
	peer.create_client(Steam.getLobbyOwner(lobby_id))
	multiplayer.multiplayer_peer = peer
		
	SceneManager.LoadDebugScene()
	get_tree().current_scene.userInterface.hide_main_menu()

func on_lobby_requested(lobby_id: int, _steam_id: int) -> void:
	Steam.joinLobby(lobby_id)










#
#func start_server() -> void:
	#is_server = true;
	#enet_peer.create_server(PORT)
	#multiplayer.peer_connected.connect(add_player)
	#multiplayer.peer_disconnected.connect(remove_player)
	#
	#multiplayer.multiplayer_peer = enet_peer
#
#func join_server() -> void:
	#if not is_server:
		#enet_peer.create_client(IP_ADRESS, PORT)
		#multiplayer.peer_connected.connect(add_player)
		#multiplayer.peer_disconnected.connect(remove_player)
		#
	#elif is_server:
		#add_player(multiplayer.get_unique_id())
		#
	#multiplayer.connected_to_server.connect(on_connected_to_server)
	#multiplayer.multiplayer_peer = enet_peer
	#
	#
#
#func on_connected_to_server() -> void:
	#add_player(multiplayer.get_unique_id())
	#
#func add_player(peer_id: int) -> void:
	#
	#var new_player: Node = PLAYER.instantiate()
	#var player_cam: Node = CAM_RIG.instantiate()
	#new_player.name = str(peer_id)
	#player_cam.name = str(peer_id)+ "_cam"
	#get_tree().current_scene.add_child(new_player, true)
#
	#if get_tree().current_scene.name == "test_scene":
		#get_tree().get_root().get_node("test_scene/SubViewportContainer/SubViewport").add_child(player_cam, true)
	#else:
		#get_tree().get_root().get_node("SceneManager/test_scene/SubViewportContainer/SubViewport").add_child(player_cam, true)
#
	#player_cam.target = new_player
#
#func remove_player(peer_id: int) -> void:
	#if peer_id == 1:
		#leave_server()
	#
	#var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	#var player_to_remove: int = players.find_custom(func(item: Node) -> bool: return item.name == str(peer_id))
	#if player_to_remove != -1:
		#players[player_to_remove].queue_free()
	#
#func leave_server() -> void:
	#multiplayer.multiplayer_peer.close()
	#multiplayer.multiplayer_peer = null
	#clean_up_signals()
	#get_tree().quit()
	#
#func clean_up_signals() -> void:
	#multiplayer.peer_connected.disconnect(add_player)
	#multiplayer.peer_disconnected.disconnect(remove_player)
	#multiplayer.connected_to_server.disconnect(on_connected_to_server)
