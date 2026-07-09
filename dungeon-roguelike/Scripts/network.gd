extends Node

signal host_created()

var peer : SteamMultiplayerPeer

const LOBBY_TYPE := Steam.LobbyType.LOBBY_TYPE_FRIENDS_ONLY
const MAX_MEMBERS := 4
static var is_steam_initialized := false


func _ready() -> void:	
	if not Steam.isSteamRunning():
		is_steam_initialized = false
		return
	else:
		is_steam_initialized = true
	
	Steam.initRelayNetworkAccess()
	Steam.lobby_created.connect(on_lobby_created)
	Steam.lobby_joined.connect(on_lobby_joined)
	Steam.join_requested.connect(on_lobby_requested)
	
	#multiplayer.peer_disconnected.connect(remove_player)
	
	#if get_tree().current_scene.name == "test_scene":
		#if OS.has_feature('server'):
			#Network.start_server()
			#add_player(multiplayer.get_unique_id())
		#else:
			#get_tree().quit()

func _process(_delta: float) -> void:
	if !is_steam_initialized:
		return
	
	Steam.run_callbacks()

func host_lobby() -> void:
	if !is_steam_initialized:
		host_created.emit()
		return
		
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

func remove_player(peer_id: int) -> void:
	if peer_id == 1:
		leave_server()
	
	var players: Array[Node] = get_tree().get_nodes_in_group("Player")
	var player_to_remove: int = players.find_custom(func(item: Node) -> bool: return item.name == str(peer_id))
	if player_to_remove != -1:
		players[player_to_remove].queue_free()
		
func leave_server() -> void:
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = null
	clean_up_signals()
	get_tree().quit()
	
func clean_up_signals() -> void:
	multiplayer.peer_disconnected.disconnect(remove_player)
	Steam.lobby_created.disconnect(on_lobby_created)
	Steam.lobby_joined.disconnect(on_lobby_joined)
	Steam.join_requested.disconnect(on_lobby_requested)
