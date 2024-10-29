extends CharacterBody2D


signal projectile_instantiated


const camera_projectile_scene = preload("res://game/scenes/camera_enemy_projectile.tscn")

var in_notice_area: bool = false
var in_attack_area: bool = false
var in_kill_camera_area: bool = false
var can_shoot: bool = true
var projectile_speed = 500

func _process(delta):
		if in_notice_area and in_attack_area and can_shoot and not Global.on_vent:
			var random_child = randi() % $ShootMarkers.get_child_count()
			var marker_node = $ShootMarkers.get_child(random_child)
			
			var camera_projectile = camera_projectile_scene.instantiate()
			$"../../AudioManager/SFX/Projectile".play()
			$"../../AudioManager/SFX/Projectile".position = $".".global_position
			get_parent().add_child(camera_projectile)
			camera_projectile.global_position = marker_node.global_position
			
			# Calculate the direction from the projectile to the player
			var direction = (Global.player.global_position - camera_projectile.global_position).normalized()
			camera_projectile.direction = direction  # Set the direction in the projectile
			
			camera_projectile.speed = projectile_speed  # Set the speed if needed
			can_shoot = false
			$ShootCooldown.start()
			print(camera_projectile.global_position)
		
		if in_kill_camera_area and Input.is_action_just_pressed("interact"):
			$AnimatedSprite2D.play("death")
			Global.player_attacking = true
			$GPUParticles2D.emitting = true
			$ShootArea/CollisionShape2D.disabled = true
			await $AnimatedSprite2D.animation_finished
			Global.player_attacking = false
			queue_free()

func _on_notice_area_body_entered(_body: Node2D) -> void:
	in_notice_area = true
	if not in_attack_area:
		$AnimatedSprite2D.play("active")
	else:
		$AnimatedSprite2D.play("shoot")
	$ExclamationMark.visible = true
	await get_tree().create_timer(0.5).timeout
	$ExclamationMark.visible = false

func _on_notice_area_body_exited(_body: Node2D) -> void:
	in_notice_area = false
	$AnimatedSprite2D.play("idle")
	$QuestionMark.visible = true
	await get_tree().create_timer(0.5).timeout
	$QuestionMark.visible = false

func _on_shoot_area_body_entered(body: Node2D) -> void:
	in_attack_area = true
	$AnimatedSprite2D.play("shoot")

func _on_shoot_area_body_exited(body: Node2D) -> void:
	in_attack_area = false
	if in_notice_area:
		$AnimatedSprite2D.play("active")
	else:
		$AnimatedSprite2D.play("idle")

func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true


func _on_kill_camera_area_body_entered(body: Node2D) -> void:
	if body == Global.player:
		in_kill_camera_area = true
		$Skull.visible = true


func _on_kill_camera_area_body_exited(body: Node2D) -> void:
	if body == Global.player:
		in_kill_camera_area = false
		$Skull.visible = false
