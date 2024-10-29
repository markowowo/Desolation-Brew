extends Control

	
func _on_quit_button_pressed():
	get_tree().quit()


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://game/scenes/settings_screen.tscn")


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://game/scenes/main_game.tscn")
	MainMenuTheme.stop()
	


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/credits_screen.tscn")
