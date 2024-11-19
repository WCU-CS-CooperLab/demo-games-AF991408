extends Node2D

@onready var player = get_node("/root/level1/AdventureGuy")  # Adjust the path to your player node

var seconds = 0 # Used for adding time to the GlobalData.player_time.

func _ready():
	# Show intro message once when entering the level
	$ScoreTimer.start()
	$HUD.update_level("Level 1")
	$HUD/HBoxContainer/key1.visible=false
	$HUD/keynum.visible=false
	if not GameState.has_shown_intro_message:
		$bedN.play()

		$HUD.show_message("What time is it?!? I must've overslept!!")
		GameState.has_shown_intro_message = true  # Set the flag to true to prevent it from showing again
		update_object_states()
		$level1song.play()

	# Check if the player has gone downstairs and update their position
	if GameState.has_gone_downstairs:
		# Set player position to the door, but slightly below it
		$maindoorN.play()
		player.position = GameState.last_door_position + Vector2(0, 50)  # Adjust the Y offset (50 units down)
	 
	update_chest_visibility()


func update_object_states():
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

# Function to update ChestObj visibility based on GameState
func update_chest_visibility():
	var chest_obj = get_node_or_null("Chest/ChestObj")  # Adjust the path to include the parent node
	print("Setting ChestObj visibility to:", GameState.has_gone_downstairs)
	chest_obj.visible = GameState.has_gone_downstairs  # Show if the player has gone downstairs

# Door collision logic
func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "AdventureGuy":  # Ensure the player is the one entering the door
		GameState.has_gone_downstairs = true
		GameState.last_door_position = Vector2(17.5, -21)  # Example position
		_load_next_scene()

func _load_next_scene():
	$ScoreTimer.stop()
	GlobalData.player_time += seconds
	get_tree().change_scene_to_file("res://level2/level2.tscn")  # Adjust path if necessary

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $PauseMenu.visible:
			$PauseMenu.visible = false
		else:
			$PauseMenu.visible = true

func _on_score_timer_timeout() -> void:
	seconds += 1
