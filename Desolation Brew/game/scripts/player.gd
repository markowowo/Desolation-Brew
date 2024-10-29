extends CharacterBody2D

var running: bool = false
@export var normal_speed = 200
@onready var camera_position = $Camera2D.position

func _ready() -> void:
	Global.player = self


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().change_scene_to_file("res://game/scenes/pause_screen.tscn")
	var direction = Input.get_vector("left", "right", "up", "down")
	position += direction * Global.player_speed * delta
	if Global.stamina <= 0:
		running = false
		Global.player_speed = normal_speed
	if Input.is_action_just_pressed("run"):
		if running:
			running = false
			Global.player_speed = normal_speed
		else:
			running = true
			Global.player_speed *= 1.5
	
	if direction != Vector2.ZERO:
		if direction.x > 0:
			$PlayerSprite.flip_h = false
		elif direction.x < 0:
			$PlayerSprite.flip_h = true

		$PlayerSprite.play("run")
	else:
		$PlayerSprite.play("idle")
	
	if Global.player_attacking == true:
		$PlayerSprite.play("shoot up")
	
	move_and_slide()


func _on_lose_stamina_cooldown_timeout() -> void:
	if running == true:
		Global.stamina -= 1
	else:
		if Global.stamina < 100:
			Global.stamina += 0.5
	if Global.health <100:
		Global.health += 0.1
