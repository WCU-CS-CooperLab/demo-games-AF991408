extends Node2D

var is_open = false  # Tracks whether the chest has been opened
var player_in_range = false  # Tracks whether the player is near the chest

func _ready():
	# Connect signals for Area2D to detect player entering/exiting
	$HUD/Time.visible=false
	$HUD/MarginContainer/Level.visible=false
	$HUD/MarginContainer/Score.visible=false
	$HUD/HBoxContainer/key1.visible=false
	$HUD/keynum.visible=false
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	$Area2D.connect("body_exited", Callable(self, "_on_body_exited"))

	# Check the GameState to see if the chest has already been opened
	if GameState.has_interacted_with_chest:
		hide()  # Make the chest invisible if already interacted with

func _on_body_entered(body):
	if body.name == "AdventureGuy":
		player_in_range = true  # Player is in range to interact with the chest

func _on_body_exited(body):
	if body.name == "AdventureGuy":
		player_in_range = false  # Player is no longer in range

func _process(delta):
	if Input.is_action_just_pressed("Interact") and player_in_range:
		open_chest()

func open_chest():
	if not is_open:  # Only open if it hasn't been opened already
		is_open = true
		print("Player opened the chest")
		
		# Update the GameState to mark the chest as interacted with
		GameState.has_interacted_with_chest = true
		
		# Hide the chest after interaction
		hide()
		$shoesN.play()

		$HUD.show_message("You opened the chest! You find your worn-out shoes!")
