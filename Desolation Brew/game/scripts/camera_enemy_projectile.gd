extends Area2D  # Change this to Node2D if your projectile is a Node2D

# Define the properties
var direction: Vector2 = Vector2.ZERO
var speed: float = 500.0

# Update the projectile's position each frame
func _process(delta: float) -> void:
	global_position += direction * speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	if body == Global.player:
		Global.health -= 10
	queue_free()
