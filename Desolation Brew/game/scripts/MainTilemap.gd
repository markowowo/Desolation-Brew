extends TileMap

var alternate: bool = false


func _process(_delta: float) -> void:
	if alternate == true:
		set_cell(3, Vector2i(3, 3), 2, Vector2i(7, 0))
	else:
		set_cell(3, Vector2i(3, 3), 2, Vector2i(8, 0))


func _on_alternate_timer_timeout() -> void:
	alternate = !alternate

