extends Node2D

signal guard_entered


func _on_tv_storage_room_body_entered(body):
	guard_entered.emit()


func _on_main_research_room_body_entered(body):
	guard_entered.emit()
