extends Node

# Global state variables
var has_shown_intro_message = false
var has_shown_downstairs_message = false  # Track if the downstairs message has been shown
var has_gone_downstairs: bool = false
var last_door_position: Vector2 = Vector2()  # Store the position as a Vector2

var player_time: float = 0.0

# Add these variables to track object interactions
var has_interacted_with_journal = false
var has_interacted_with_chest = false
var has_interacted_with_hammer = false
var has_interacted_with_book = false
