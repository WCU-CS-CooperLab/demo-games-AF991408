extends Node2D  # This script is attached to the Node2D "journal"

@onready var journal_sprite = $JournalObj  # Reference the journal sprite
@onready var area = $Area2D  # Reference the Area2D node under this Node2D

func _ready() -> void:
	# Check if the journal has already been collected
	$HUD/Time.visible=false
	$HUD/MarginContainer/Level.visible=false
	$HUD/MarginContainer/Score.visible=false
	$HUD/HBoxContainer/key1.visible=false
	$HUD/keynum.visible=false
	
	
	if GameState.has_interacted_with_journal:
		hide_journal()  # Hide it if it has already been picked up
	else:
		# Connect the Area2D's body_entered signal to the function
		area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Check if the body is the player (AdventureGuy)
	if body.name == "AdventureGuy":
		
		$journalN.play()
		$HUD.show_message("The Legend of the Stone Bridge, one of my favorites")
		hide_journal()
		# Mark in GameState that the journal has been collected
		GameState.has_interacted_with_journal = true

func hide_journal() -> void:
	# Hide the journal sprite (make it disappear)
	journal_sprite.visible = false
	print("Journal collected!")
