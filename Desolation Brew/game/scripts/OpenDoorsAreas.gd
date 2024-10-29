extends Node2D



func _on_sr_1_first_door_body_entered(body: Node2D) -> void:
	if body == $"../Player":
		if $"../AudioManager/Music/MysteriousTheme".playing == true:
			$"../AudioManager/Music/MysteriousTheme".stop()
		if $"../AudioManager/Music/WeirdPianoTheme".playing == false:
			$"../AudioManager/Music/WeirdPianoTheme".play()
		else:
			pass
		if $"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1FirstDoor" != null:
			$"../AudioManager/SFX/DoorOpen".play()
			$"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1FirstDoor".play("open door")
			await $"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1FirstDoor".animation_finished
			$"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1FirstDoor".queue_free()
	if body == $"../DentonCharacter":
		if $"../AnimationPlayers/OpenDoors/RR3DoorLine/RR3FirstDoor" != null:
			$"../AudioManager/SFX/DoorOpen".play()
			$"../AnimationPlayers/OpenDoors/RR3DoorLine/RR3FirstDoor".play("open door")
			await $"../AnimationPlayers/OpenDoors/RR3DoorLine/RR3FirstDoor".animation_finished
			$"../AnimationPlayers/OpenDoors/RR3DoorLine/RR3FirstDoor".queue_free()
		


func _on_sr_1_second_door_body_entered(_body: Node2D) -> void:
	if $"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1SecondDoor" != null:
		$"../AudioManager/SFX/DoorOpen".play()
		$"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1SecondDoor".play("open door")
		await $"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1SecondDoor".animation_finished
		$"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1SecondDoor".queue_free()


func _on_sr_1_third_door_body_entered(_body: Node2D) -> void:
	if $"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1ThirdDoor" != null:
		$"../AudioManager/SFX/DoorOpen".play()
		$"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1ThirdDoor".play("open door")
		await $"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1ThirdDoor".animation_finished
		$"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1ThirdDoor".queue_free()


func _on_sr_1_fourth_door_body_entered(_body: Node2D) -> void:
	if $"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1FourthDoor" != null:
		$"../AudioManager/SFX/DoorOpen".play()
		$"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1FourthDoor".play("open door")
		await $"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1FourthDoor".animation_finished
		$"../AnimationPlayers/OpenDoors/SR1DoorLine/SR1FourthDoor".queue_free()


func _on_cafeteria_exit_door_body_entered(body: Node2D) -> void:
	if body == $"../DentonCharacter":
		if $"../AnimationPlayers/OpenDoors/CafeteriaExitDoor" != null:
			$"../AudioManager/SFX/DoorOpen".play()
			$"../AnimationPlayers/OpenDoors/CafeteriaExitDoor".play("open door")
			await $"../AnimationPlayers/OpenDoors/CafeteriaExitDoor".animation_finished
			$"../AnimationPlayers/OpenDoors/CafeteriaExitDoor".queue_free()


func _on_main_hall_door_body_entered(body):
	if $"../AnimationPlayers/OpenDoors/MainHallDoor" != null:
		$"../AudioManager/SFX/DoorOpen".play()
		$"../AnimationPlayers/OpenDoors/MainHallDoor".play("open door")
		await $"../AnimationPlayers/OpenDoors/MainHallDoor".animation_finished
		$"../AnimationPlayers/OpenDoors/MainHallDoor".queue_free()




func _on_administrative_office_door_body_entered(body):
	if $"../AnimationPlayers/OpenDoors/AdminstrativeOfficeDoor" != null:
		$"../AudioManager/SFX/DoorOpen".play()
		$"../Enemies/GuardEnemy2".queue_free()
		$"../Enemies/CameraEnemy15".queue_free()
		$"../Enemies/CameraEnemy7".queue_free()
		$"../AnimationPlayers/OpenDoors/AdminstrativeOfficeDoor".play("open  door")
		await $"../AnimationPlayers/OpenDoors/AdminstrativeOfficeDoor".animation_finished
		$"../AnimationPlayers/OpenDoors/AdminstrativeOfficeDoor".queue_free()
		$"../DentonCharacter".position = Vector2(8484, -6400)
		$"../DentonCharacter".get_node("NavigationAgent2D").target_position = Vector2(7806, -7325)
