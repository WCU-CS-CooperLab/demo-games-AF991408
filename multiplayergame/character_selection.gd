extends Node2D

var selected_index : int = 0
@export var selection_indicator : TextureRect

func _ready():
	pass	

func _on_button_pressed() -> void:
	# Set index in gamestate
	Gamestate.selected_character_index = 0
	get_tree().change_scene_to_file("res://arenas/arena_number_whatever.tscn")

func _on_button_2_pressed() -> void:
	# Set index in gamestate
	Gamestate.selected_character_index = 1
	get_tree().change_scene_to_file("res://arenas/arena_number_whatever.tscn")

func _on_button_3_pressed() -> void:
	# Set index in gamestate
	Gamestate.selected_character_index = 2
	get_tree().change_scene_to_file("res://arenas/arena_number_whatever.tscn")
