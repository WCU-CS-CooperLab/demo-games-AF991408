extends Node

var selected_character_index : int = -1

# Reference to the character scenes for each character
@export var blue_player : PackedScene
@export var red_player : PackedScene
@export var big_guy : PackedScene

# Reference to the Marker2D nodes for spawn positions
@export var bluespawn : Marker2D
@export var redspawn : Marker2D
@export var bigspawn : Marker2D

func _ready():
	# Get the selected character index from GameState
	selected_character_index = Gamestate.selected_character_index
	
	# Spawn the selected character
	spawn_character()

func spawn_character():
	match selected_character_index:
		0:
			spawn_character_at_marker(red_player, redspawn)
		1:
			spawn_character_at_marker(blue_player, bluespawn)
		2:
			spawn_character_at_marker(big_guy, bigspawn)
		_:
			print("No character selected.")
			return

func spawn_character_at_marker(player_scene: PackedScene, spawn_marker: Marker2D):
	# Instantiate the character from the PackedScene
	var character = player_scene.instantiate()
	
	# Set the character's position to the spawn marker's position
	character.global_position = spawn_marker.global_position
	
	# Add the character to the current scene
	add_child(character)
