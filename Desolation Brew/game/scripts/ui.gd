extends CanvasLayer


func _process(delta: float) -> void:
	$MarginContainer/HealthBar.value = Global.health
	$MarginContainer2/StaminaBar.value = Global.stamina


func _on_denton_character_darken() -> void:
	$".".visible = false


func _on_denton_character_light() -> void:
	$".".visible = true
