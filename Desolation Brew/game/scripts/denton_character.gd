extends CharacterBody2D

signal dialogue_finished
signal darken
signal light

var speed: int = 200
var in_talk_area: bool = false
var can_interact: bool = true
var moving: bool = false

var dialogue_in_progress: bool = false


var dialogues_finished: int = 0

var current_dialogue_index: int = 0

var dialogue1 = ["???:\nHuh... who are you?!",
"???:\nOh... right. Must be that note I dropped somewhere.",
"???:\nI had plenty of time to check all my pockets, of course.",
"???:\nAnyway, thanks for saving me.",
"???:\nThe issues with power really messed up the door functions...",
"???:\nI couldn't open the doors from the inside, but they work from the outside.",
"???:\nLooks like the doors also stay permanently open after they are opened now.",
"???:\nThat's... Convenient? I hope.",
"???:\nLet's get out of this room and I'll tell you some things I know about this place while we move.",
"???:\nTrust me, there is a LOT to take in.",
"???:\nAs you probably could've guessed, my name is Denton. Nice to meet you.",
"Denton:\nThank you, friend."]

var dialogue2 = ["Denton:\nI guess I should first tell you about the room we are in right now.",
"Denton:\nAs you can probably tell from the plastered labels and hazard signs all over the walls...",
"Denton:\nThis is Storage Room 1.",
"Denton:\nIt contains some of the world's most toxic minerals.",
"Denton:\nThis room here holds mostly Cinnabar and Arsenic, but also has some Chalcanthite and...",
"Denton:\nI don't think you care. Sorry.",
"Denton:\nAnyway... they definitely shouldn't be scrambled on the ground like this.",
"Denton:\nLet's get out of here quick. Follow me!"]

var dialogue3 = ["Denton:\nSo... this is Research Room 3.",
"Denton:\nHow did I open that door over there?",
"Denton:\nThey installed some sort of chip on me that allows me to open every door on sight.",
"Denton:\nCould come in handy at some point. Keep that in mind.",
"Denton:\nSo, I guess I should tell you some things about this place while we're here.",
"Denton:\nThis lab is called Nihilum Engineering.",
"Denton:\nI came to this lab under the premise that it is a place where I can grow my career.",
"Denton:\nI was confused by the amount of toxic minerals, but, I assumed that's good for my career.",
"Denton:\nThey never really told me what I'm working for... Just gave me tasks and plenty of bonuses.",
"Denton:\nI was amazed by how much I was earning and I felt truly respected.",
"Denton:\nI didn't want to give that up.",
"Denton:\nI never found out either. I still don't know what goes on out there.",
"Denton:\nBut... given how I was just left locked here for so long, I doubt it's anything positive.",
"Denton:\nSo, the Research Room is what you'd expect. A room with computers and screens.",
"Denton:\nYou could be optimizing extraction, optimizing software, developing formulas, logistics...",
"Denton:\nIt all depends on your particular field.",
"Denton:\nYou may have noticed, some computers that are on can be interacted with and they talk to you.",
"Denton:\nNext up, I'll show you another lab that's disconnected from this one.",
"Denton:\nTalk to me when you're ready."]

var dialogue4 = ["Denton:\nReady?",
"Denton:\nLet's go."]

var dialogue5 = ["Denton:\nAre you coming???",
"Denton:\nThis is the other lab.",
"Denton:\nI'll let you explore a bit, but be careful, it can be dangerous here.",
"Denton:\nThere could be enemies that will try to attack you.",
"Denton:\nIf there happens to be a door you can't open or you see anything suspicious,",
"Denton:\nYou know what to do."]

var dialogue6 = ["Denton:\nAlright, so I'm not sure if you actually went to explore or not...",
"Denton:\nBut, I will tell you about the 2 possible dangers in this lab, which you probably saw.",
"Denton:\nThere is the Camera. When it sees you, it starts shooting. Pretty simple.",
"Denton:\nTo get rid of the Camera, you walk up close to it and attack it twice.",
"Denton:\nThe first attack disables the Camera's shooting capabilities,",
"Denton:\nAnd the second attack destroys the Camera.",
"Denton:\nThe Guard patrols an area or it free roams around the entire lab.",
"Denton:\nSince you can't fight back, you will just have to avoid them.",
"Denton:\nLuckily, they are pretty easy to dodge. And you're just here to get information.",
"Denton:\nYou might encounter more enemies at some point, but there's no time now.",
"Denton:\nNow follow me. Remember what I told you about the enemies."]

var dialogue7 = ["Denton:\nYou can see they went for a more...",
"Denton:\nOpen look.",
"Denton:\nIt can be a bit difficult to navigate through.",
"Denton:\nThey didn't want just about anyone to easily come here and do what they want.",
"Denton:\nJust follow the signs and it shouldn't be TOO bad.",
"Denton:\nIt's dangerous here. I need to get out of here.",
"Denton:\nOh, and I forgot to mention something important,",
"Denton:\nWhen you see smoke coming out of vents, you can get behind it.",
"Denton:\nIt will obscure the enemies' vision. Use it well and strategically.",
"Denton:\nRemember the things I tell you. Navigate through them and get information.",
"Denton:\nI will leave now but I will know when you'll need me. Trust me."]

var dialogue8 = ["Denton:\nI got here pretty quickly, right?",
"Denton:\nSo... you got to the admin office. Good job. We can definitely find out a lot now.",
"Denton:\nWait... what is that?"]

func _ready():
	dialogues_finished = 0


func _process(delta: float) -> void:
	if dialogue_in_progress:
		$AnimatedSprite2D.play("talk")
	else:
		$AnimatedSprite2D.play("idle1")
	if moving == true:
		$TalkArea.monitoring = false
	else:
		$TalkArea.monitoring = true
		
	if in_talk_area and Input.is_action_just_pressed("interact") and $".".position == Vector2(4077, -1425):
		dialogue_in_progress = true
		display_next_dialogue(dialogue1, 4)
	elif in_talk_area and Input.is_action_just_pressed("interact") and dialogues_finished == 1:
		if $".".position >= Vector2(3320, -1220) or $".".position <= Vector2(3330, -1220):
			dialogue_in_progress = true
			display_next_dialogue(dialogue2, 5.4)
	elif in_talk_area and Input.is_action_just_pressed("interact") and dialogues_finished == 2:
		if $".".position >= Vector2(2815, -455) or $".".position <= Vector2(2825, -445):
			dialogue_in_progress = true
			display_next_dialogue(dialogue3, 1)
	elif in_talk_area and Input.is_action_just_pressed("interact") and dialogues_finished == 3:
		if $".".position >= Vector2(2815, -455) or $".".position <= Vector2(2825, -445):
			dialogue_in_progress = true
			display_next_dialogue(dialogue4, 0)
	elif in_talk_area and Input.is_action_just_pressed("interact") and dialogues_finished == 4:
		dialogue_in_progress = true
		display_next_dialogue(dialogue5, 0)
		if current_dialogue_index == 2:
			if $"../AudioManager/Music/WeirdPianoTheme".playing == true:
				$"../AudioManager/Music/WeirdPianoTheme".stop()
			if $"../AudioManager/Music/CrazyRoboTheme".playing == false:
				$"../AudioManager/Music/CrazyRoboTheme".play()
			else:
				pass
			$"../Player".get_node("MoveCamera").play("show lab")
			await get_tree().create_timer(10).timeout 
			$"../Player".get_node("MoveCamera").queue_free()
	elif in_talk_area and Input.is_action_just_pressed("interact") and dialogues_finished == 5:
		dialogue_in_progress = true
		display_next_dialogue(dialogue6, 16.5)
	elif in_talk_area and Input.is_action_just_pressed("interact") and dialogues_finished == 6:
		if $".".position >= Vector2(8400, -4740):
			dialogue_in_progress = true
			display_next_dialogue(dialogue7, 20)
	elif in_talk_area and Input.is_action_just_pressed("interact") and dialogues_finished == 7:
		if $".".position >= Vector2(7740, -7420):
			display_next_dialogue(dialogue8, 0)
	
	if not dialogue_in_progress:
		var next_path_pos = $NavigationAgent2D.get_next_path_position()
		var direction: Vector2 = (next_path_pos - global_position).normalized()
		velocity = direction * speed
		move_and_collide(velocity * delta)

func _on_talk_area_body_entered(_body: Node2D) -> void:
	in_talk_area = true
	if not moving:
		$EToInteract.visible = true

func _on_talk_area_body_exited(_body: Node2D) -> void:
	in_talk_area = false
	if moving:
		$EToInteract.visible = false

func display_next_dialogue(dialogue, time):
	if current_dialogue_index < dialogue.size():
		$"../AudioManager/SFX/NextDialogue".play()
		$DialoguePopupCanvas/DialogueLabel.visible = true
		var dialogue_line = dialogue[current_dialogue_index]
		$DialoguePopupCanvas/DialogueLabel.text = dialogue_line
		current_dialogue_index += 1
	else:
		dialogue_in_progress = false
		$DialoguePopupCanvas/DialogueLabel.visible = false
		$EToInteract.visible = false
		dialogue_finished.emit()
		moving = true
		await get_tree().create_timer(time).timeout
		moving = false

func _on_dialogue_finished() -> void:
	dialogues_finished += 1
	if dialogues_finished == 1:
		current_dialogue_index = 0
		$NavigationAgent2D.target_position = Vector2(3386, -1125)
		await get_tree().create_timer(0.1).timeout
	elif dialogues_finished == 2:
		current_dialogue_index = 0
		$NavigationAgent2D.target_position = Vector2(2883, -364)
		await get_tree().create_timer(0.1).timeout
	elif dialogues_finished == 3:
		current_dialogue_index = 0
	elif dialogues_finished == 4:
		current_dialogue_index = 0
		darken.emit()
		var darken_tween = create_tween()
		darken_tween.tween_property($"..", "modulate", Color8(0, 0, 0, 255), 3)
		darken_tween.play()
		await get_tree().create_timer(5).timeout
		$".".position = Vector2(8064, -1150)
		$NavigationAgent2D.target_position = Vector2(8287, -1380)
		$"../Player".position = Vector2(8016, -1090)
		await get_tree().create_timer(0.1).timeout
		$"../DirectionalLight2D".visible = false
		light.emit()
		var light_tween = create_tween()
		light_tween.tween_property($"..", "modulate", Color8(255, 255, 255, 255), 3)
		light_tween.play()
		await light_tween.finished
		display_next_dialogue(dialogue5, 0)
	elif dialogues_finished == 5:
		current_dialogue_index = 0
	elif dialogues_finished == 6:
		current_dialogue_index = 0
		$NavigationAgent2D.target_position = Vector2(8473, -4641)
		await get_tree().create_timer(0.1).timeout
	elif dialogues_finished == 7:
		current_dialogue_index = 0
		$FlashParticles.emitting = true
		await get_tree().create_timer(1).timeout
		$".".position = Vector2(2709, -906)
	elif dialogues_finished == 8:
		current_dialogue_index = 0
		await get_tree().create_timer(0.1).timeout
		var dark_tween = create_tween()
		dark_tween.tween_property($"..", "modulate", Color8(0, 0, 0, 255), 2)
		dark_tween.play()
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://game/scenes/demo_over_screen.tscn")
		
