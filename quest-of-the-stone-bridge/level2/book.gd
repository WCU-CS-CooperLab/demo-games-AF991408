extends Node2D

var is_open = false
var player_in_range = false

# Declare the signal at the top level, outside of any function
signal book_opened  # Signal to notify the level script when the book is opened

func _ready():
	# Check if the book has already been interacted with
	$HUD/Time.visible=false
	$HUD/MarginContainer/Level.visible=false
	$HUD/MarginContainer/Score.visible=false
	$HUD/HBoxContainer/key1.visible=false
	$HUD/keynum.visible=false
	if GameState.has_interacted_with_book:
		hide_book()  # Hide the book immediately if it's already opened
	else:
		$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
		$Area2D.connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "AdventureGuy":  # Assumes your player is named "AdventureGuy"
		player_in_range = true

func _on_body_exited(body):
	if body.name == "AdventureGuy":
		player_in_range = false

func open_book():
	if not is_open:
		is_open = true
		print("Player interacted with the book")
		$BookObj.visible = false  # Hide the Sprite2D named BookObj
		
		# Show the quest-related messages
		$bookN.play()
		$HUD.show_message("Quick, find your items for your quest!")
		await get_tree().create_timer(1.5).timeout
		$HUD.show_message("Collect your Shoes, Hammer, and Journal!")
		await get_tree().create_timer(1.5).timeout
		
		# Mark the book as interacted in GameState
		GameState.has_interacted_with_book = true

		# Emit the book_opened signal for other scripts to react
		emit_signal("book_opened")

func _process(delta):
	if Input.is_action_just_pressed("Interact") and player_in_range:
		open_book()

func hide_book() -> void:
	# Hide the book sprite (make it disappear)
	$BookObj.visible = false
	print("Book has already been collected!")
