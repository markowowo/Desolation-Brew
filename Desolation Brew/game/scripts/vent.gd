extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body == Global.player:
		Global.on_vent = true
		
		
func _on_body_exited(body: Node2D) -> void:
	if body == Global.player:
		Global.on_vent = false
