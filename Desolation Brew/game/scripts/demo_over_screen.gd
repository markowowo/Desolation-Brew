extends Control

func _ready():
	MainMenuTheme.play()

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/scenes/credits_screen.tscn")
