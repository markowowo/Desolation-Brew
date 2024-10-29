extends CanvasLayer

@onready var label = $".".get_child(0)

func _process(_delta):
	if DisplayServer.WINDOW_MODE_WINDOWED:
		offset = Vector2(-77, 85)
	if DisplayServer.WINDOW_MODE_FULLSCREEN:
		offset = Vector2(220, 100)
	if label != null:
		label.position = offset
