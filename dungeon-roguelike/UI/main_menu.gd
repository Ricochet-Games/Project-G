extends CanvasLayer

func _on_create_lobby_pressed() -> void:
	Network.host_lobby()
	SceneManager.LoadDebugScene()
	hide()

func _on_quit_game_pressed() -> void:
		get_tree().quit()
