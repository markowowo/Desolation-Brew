extends Control


func _on_full_screen_setting_pressed():
	if $FullScreenSetting.button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://game/scenes/main_menu.tscn")


func _on_controls_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/controls_screen.tscn")
