extends CharacterBody2D

const camera_projectile_scene = preload("res://game/scenes/camera_enemy_projectile.tscn")

var in_notice_area: bool = false
var in_shoot_area: bool = false
var can_shoot: bool = true
var projectile_speed: int = 500
var speed = 100
var direction = Vector2.ZERO


func _process(delta: float) -> void:
	var velocity = direction * speed * delta
	if in_notice_area and not Global.on_vent:
		speed = 100
		direction = (Global.player.global_position - position).normalized()
		velocity = direction * speed * delta
		move_and_collide(velocity)
		if direction != Vector2.ZERO:
			if direction.x > 0:
				$AnimatedSprite2D.flip_h = false
			elif direction.x < 0:
				$AnimatedSprite2D.flip_h = true
	else:
		var collision = move_and_collide(velocity)
		if collision:
			direction = direction.rotated(PI)
			$AnimatedSprite2D.flip_h = direction.x < 0
		if direction != Vector2.ZERO:
			if direction.x > 0:
				$AnimatedSprite2D.flip_h = false
			elif direction.x < 0:
				$AnimatedSprite2D.flip_h = true

	if in_shoot_area and can_shoot and not Global.on_vent:
		var marker_node = $Marker2D
		var camera_projectile = camera_projectile_scene.instantiate()
		$"../../AudioManager/SFX/Projectile".play()
		$"../../AudioManager/SFX/Projectile".position = $".".global_position
		get_parent().add_child(camera_projectile)
		camera_projectile.global_position = marker_node.global_position
		var projectile_direction = (Global.player.global_position - camera_projectile.global_position).normalized()
		camera_projectile.direction = projectile_direction
		camera_projectile.speed = projectile_speed
		can_shoot = false
		$ShootCooldown.start()


func _on_notice_area_body_entered(body: Node2D) -> void:
	in_notice_area = true
	if not in_shoot_area:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("shoot")
	$ExclamationMark.visible = true
	await get_tree().create_timer(0.5).timeout
	$ExclamationMark.visible = false

func _on_notice_area_body_exited(body: Node2D) -> void:
	in_notice_area = false
	$AnimatedSprite2D.play("idle")
	$QuestionMark.visible = true
	await get_tree().create_timer(0.5).timeout
	$QuestionMark.visible = false

func _on_shoot_area_body_entered(body: Node2D) -> void:
	in_shoot_area = true
	$AnimatedSprite2D.play("shoot")

func _on_shoot_area_body_exited(body: Node2D) -> void:
	in_shoot_area = false
	if in_notice_area:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")

func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true


func _on_move_timer_timeout() -> void:
	var angle = randf() * 2 * PI
	direction = Vector2(cos(angle), sin(angle)).normalized()
	speed = randf_range(25, 75)
	$MoveTimer.wait_time = randf_range(0.5, 1.5)

	if direction != Vector2.ZERO:
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")


func _on_guard_doors_guard_entered() -> void:
	direction = direction.rotated(PI)
	$AnimatedSprite2D.flip_h = direction.x < 0
