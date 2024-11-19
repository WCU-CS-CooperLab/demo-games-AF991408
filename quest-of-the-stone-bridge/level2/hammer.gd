extends Node2D  # This script is attached to the Node2D "Hammer"

@onready var hammer_sprite = $hammerObj  # Reference the hammer sprite
@onready var area = $Area2D  # Reference the Area2D node under this Node2D
@onready var audio_player = $AudioStreamPlayer

func _ready() -> void:
	# Check if the hammer has already been collected
	$HUD/Time.visible=false
	$HUD/MarginContainer/Level.visible=false
	$HUD/MarginContainer/Score.visible=false
	$HUD/HBoxContainer/key1.visible=false
	$HUD/keynum.visible=false
	if GameState.has_interacted_with_hammer:
		hide_hammer()  # Hide it if it has already been picked up
	else:
		# Connect the Area2D's body_entered signal to the function
		area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Check if the body is the player (AdventureGuy)
	if body.name == "AdventureGuy":
		
		$hammerN.play()

		hide_hammer()
		# Mark in GameState that the hammer has been collected
		GameState.has_interacted_with_hammer = true

func hide_hammer() -> void:
	# Hide the hammer sprite (make it disappear)
	hammer_sprite.visible = false
	print("Hammer collected!")
