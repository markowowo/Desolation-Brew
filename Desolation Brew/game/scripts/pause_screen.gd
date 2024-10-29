extends Control


func _on_menu_button_pressed() -> void:
	MainMenuTheme.play()
	get_tree().change_scene_to_file("res://game/scenes/main_menu.tscn")


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/main_game.tscn")
