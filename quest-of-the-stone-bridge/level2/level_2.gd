extends Node2D

var next_scene = "res://level_2_5.tscn"
var prev_scene = "res://level1/level1.tscn"
var seconds = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Check if the downstairs message has been shown
	$ScoreTimer.start()
	$maindoorN.play()
	$HUD.update_level("Level 2")
	$HUD/HBoxContainer/key1.visible=false
	$HUD/keynum.visible=false
	if not GameState.has_shown_downstairs_message:
		$HUD.show_message("HUH?! Where is everyone??")  # Show the message
		GameState.has_shown_downstairs_message = true  # Set the flag so the message won't show again
	update_object_states()
	$level1song.play()

func update_object_states():
# Use GameState to update the visibility of the objects

# Update Chest state
	var chest_obj = get_node_or_null("Chest/ChestObj")
	if chest_obj:
		chest_obj.visible = not GameState.has_interacted_with_chest  # Hide if already interacted

# Update Journal state
	var journal_obj = get_node_or_null("Journal/JournalObj")
	if journal_obj:
		journal_obj.visible = not GameState.has_interacted_with_journal  # Hide if already interacted

# Update Hammer state
	var hammer_obj = get_node_or_null("Hammer/HammerObj")
	if hammer_obj:
		hammer_obj.visible = not GameState.has_interacted_with_hammer  # Hide if already interacted
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $PauseMenu.visible:
			$PauseMenu.visible = false
		else:
			$PauseMenu.visible = true

func _load_next_scene():
	var new_scene = load(next_scene)  # Not necessary if using change_scene directly
	if new_scene:
		$ScoreTimer.stop()
		GlobalData.player_time += seconds
		get_tree().change_scene_to_file(next_scene)  # Use change_scene instead of change_scene_to
	else:
		print("Error: Cannot load scene: " + next_scene)

func _load_prev_scene():
	var new_scene = load(prev_scene)  # Not necessary if using change_scene directly
	if new_scene:
		$ScoreTimer.stop()
		GlobalData.player_time += seconds
		get_tree().change_scene_to_file(prev_scene)  # Use change_scene instead of change_scene_to
	else:
		print("Error: Cannot load scene: " + prev_scene)

func _on_door_body_entered(body: Node2D) -> void:
	_load_prev_scene()

func _on_trapdoor_body_entered(body: Node2D) -> void:
	$trapdoorN.play()
	await get_tree().create_timer(.5).timeout
	_load_next_scene()


func _on_outside_body_entered(body: Node2D) -> void:
	$HUD.show_message("Weird? The door to outside is locked?")
	await get_tree().create_timer(1.5).timeout
	$HUD.show_message("There must be another way!")

func _on_score_timer_timeout() -> void:
	seconds += 1
