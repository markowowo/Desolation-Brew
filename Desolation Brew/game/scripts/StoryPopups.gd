extends Node2D


var fade_in_tween
var fade_out_tween
# research rooms
var in_r1_interact_area: bool = false
var in_r2_interact_area: bool = false
var in_r3_interact_area: bool = false
var in_mr1_interact_area: bool = false
# incubation rooms
var in_i1_interact_area: bool = false
# pc rooms
var in_pc1_interact_area: bool = false
var in_pc2_interact_area: bool = false
var in_pc3_interact_area: bool = false
var in_pc_unlock_interact_area: bool = false

func _process(_delta: float) -> void:
	if in_r1_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ReadPaper".play()
		fade_in($ResearchRoom1Paper/ResearchRoom1)
		$"../InteractSprites/EToInteract".visible = false
	if in_r2_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ReadPaper".play()
		fade_in($ResearchRoom2Paper/ResearchRoom2)
		$"../InteractSprites/EToInteract3".visible = false
	if in_r3_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ReadPaper".play()
		fade_in($ResearchRoom3Paper/ResearchRoom3)
		$"../InteractSprites/EToInteract4".visible = false
	if in_mr1_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ReadPaper".play()
		fade_in($MainResearchPaper/MainResearchLabel)
		$"../InteractSprites/EToInteract8".visible = false
	if in_i1_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ReadPaper".play()
		fade_in($IncubatingRoomPaper/IncubatingRoomLabel)
		$"../InteractSprites/EToInteract6".visible = false
	if in_pc1_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ComputerInteract".play()
		fade_in($StartingRoomAreaPC/StartingRoomLabelPC)
		$"../InteractSprites/EToInteract2".visible = false
	if in_pc2_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ComputerInteract".play()
		fade_in($BigLabEntrance1/BigLabEntrancePCLabel)
		$"../InteractSprites/EToInteract5".visible = false
	if in_pc3_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ComputerInteract".play()
		fade_in($MainResearchComputer/MainResearchComputerLabel)
		$"../InteractSprites/EToInteract7".visible = false
	if in_pc_unlock_interact_area == true and Input.is_action_just_pressed("interact"):
		$"../AudioManager/SFX/ComputerInteract".play()
		fade_in($AdminUnlockComputer/AdminUnlockComputerLabel)
		$"../InteractSprites/EToInteract9".visible = false
		$"../MainTilemap".set_cell(1, Vector2i(121, -115), 2, Vector2i(0, 12))
		$"../MainTilemap".set_cell(1, Vector2i(122, -115), 2, Vector2i(1, 12))
		$"../OpenDoorsAreas/AdministrativeOfficeDoor".monitoring = true
		
func fade_in(label: Label):
	fade_in_tween = create_tween()
	fade_in_tween.tween_property(label, "modulate", Color8(255, 255, 255, 255), 1)
	fade_in_tween.play()
	

func fade_out(label: Label):
	fade_out_tween = create_tween()
	fade_out_tween.tween_property(label, "modulate", Color8(255, 255, 255, 0), 1)
	fade_out_tween.play()

func _on_starting_room_area_body_entered(_body):
	fade_in($StartingRoomAreaThought/StoryPopupCanvas/StartingRoomLabelThought)
	if $StartingRoomAreaThought/StartingRoomDoorOpen != null:
		$"../AudioManager/SFX/DoorOpen".play()
		$StartingRoomAreaThought/StartingRoomDoorOpen.play("open door")
		await $StartingRoomAreaThought/StartingRoomDoorOpen.animation_finished
		$StartingRoomAreaThought/StartingRoomDoorOpen.queue_free()
		await get_tree().create_timer(60).timeout
		$StartingRoomAreaThought/StoryPopupCanvas/StartingRoomLabelThought.queue_free()


func _on_starting_room_area_body_exited(_body):
	fade_out($StartingRoomAreaThought/StoryPopupCanvas/StartingRoomLabelThought)


func _on_starting_room_area_pc_body_entered(_body):
	in_pc1_interact_area = true
	$"../InteractSprites/EToInteract2".visible = true


func _on_starting_room_area_pc_body_exited(_body):
	in_pc1_interact_area = false
	if $"../InteractSprites/EToInteract2".visible == true:
		$"../InteractSprites/EToInteract2".visible = false
	else:
		fade_out($StartingRoomAreaPC/StartingRoomLabelPC)


func _on_research_room_1_paper_body_entered(_body: Node2D) -> void:
	in_r1_interact_area = true
	$"../InteractSprites/EToInteract".visible = true


func _on_research_room_1_paper_body_exited(_body: Node2D) -> void:
	in_r1_interact_area = false
	if $"../InteractSprites/EToInteract".visible == true:
		$"../InteractSprites/EToInteract".visible = false
	else:
		fade_out($ResearchRoom1Paper/ResearchRoom1)


func _on_interesting_layout_body_entered(_body):
	fade_in($InterestingLayout/StoryPopupCanvas/InterestingLayoutThought)
	await get_tree().create_timer(60).timeout
	if $StartingRoomAreaThought/StoryPopupCanvas/StartingRoomLabelThought != null:
		$StartingRoomAreaThought/StoryPopupCanvas/StartingRoomLabelThought.queue_free()


func _on_interesting_layout_body_exited(_body):
	fade_out($InterestingLayout/StoryPopupCanvas/InterestingLayoutThought)


func _on_research_room_2_paper_body_entered(_body):
	in_r2_interact_area = true
	$"../InteractSprites/EToInteract3".visible = true


func _on_research_room_2_paper_body_exited(_body):
	in_r2_interact_area = false
	if $"../InteractSprites/EToInteract3".visible == true:
		$"../InteractSprites/EToInteract3".visible = false
	else:
		fade_out($ResearchRoom2Paper/ResearchRoom2)


func _on_getting_dark_body_entered(_body: Node2D) -> void:
	$"../AudioManager/SFX/CircuitPop".play()
	fade_in($GettingDark/StoryPopupCanvas/GettingDark)
	var get_dark_tween = create_tween()
	get_dark_tween.tween_property($"../DirectionalLight2D", "color", Color8(152, 152, 152, 255), 8)
	get_dark_tween.play()

func _on_getting_dark_body_exited(_body: Node2D) -> void:
	fade_out($GettingDark/StoryPopupCanvas/GettingDark)
	await get_tree().create_timer(4).timeout
	if $GettingDark/StoryPopupCanvas/GettingDark != null:
		$GettingDark/StoryPopupCanvas/GettingDark.queue_free()


func _on_research_room_3_paper_body_entered(_body: Node2D) -> void:
	in_r3_interact_area = true
	$"../InteractSprites/EToInteract4".visible = true


func _on_research_room_3_paper_body_exited(_body: Node2D) -> void:
	in_r3_interact_area = false
	if $"../InteractSprites/EToInteract4".visible == true:
		$"../InteractSprites/EToInteract4".visible = false
	else:
		fade_out($ResearchRoom3Paper/ResearchRoom3)


func _on_big_lab_entrance_1_body_entered(body):
	in_pc2_interact_area = true
	$"../InteractSprites/EToInteract5".visible = true


func _on_big_lab_entrance_1_body_exited(body):
	in_pc2_interact_area = false
	if $"../InteractSprites/EToInteract5".visible == true:
		$"../InteractSprites/EToInteract5".visible = false
	else:
		fade_out($BigLabEntrance1/BigLabEntrancePCLabel)


func _on_incubating_room_paper_body_entered(body):
	in_i1_interact_area = true
	$"../InteractSprites/EToInteract6".visible = true


func _on_incubating_room_paper_body_exited(body):
	in_i1_interact_area = false
	if $"../InteractSprites/EToInteract6".visible == true:
		$"../InteractSprites/EToInteract6".visible = false
	else:
		fade_out($IncubatingRoomPaper/IncubatingRoomLabel)


func _on_main_research_computer_body_entered(body):
	in_pc3_interact_area = true
	$"../InteractSprites/EToInteract7".visible = true


func _on_main_research_computer_body_exited(body):
	in_pc3_interact_area = false
	if $"../InteractSprites/EToInteract7".visible == true:
		$"../InteractSprites/EToInteract7".visible = false
	else:
		fade_out($MainResearchComputer/MainResearchComputerLabel)


func _on_main_research_paper_body_entered(body):
	in_mr1_interact_area = true
	$"../InteractSprites/EToInteract8".visible = true


func _on_main_research_paper_body_exited(body):
	in_mr1_interact_area = false
	if $"../InteractSprites/EToInteract8".visible == true:
		$"../InteractSprites/EToInteract8".visible = false
	else:
		fade_out($MainResearchPaper/MainResearchLabel)


func _on_admin_unlock_computer_body_entered(body):
	in_pc_unlock_interact_area = true
	$"../InteractSprites/EToInteract9".visible = true


func _on_admin_unlock_computer_body_exited(body):
	in_pc_unlock_interact_area = false
	if $"../InteractSprites/EToInteract9".visible == true:
		$"../InteractSprites/EToInteract9".visible = false
	else:
		fade_out($AdminUnlockComputer/AdminUnlockComputerLabel)
