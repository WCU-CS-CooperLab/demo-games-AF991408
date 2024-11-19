extends Node2D

var next_scene = "res://level_3.tscn"
var prev_scene = "res://level2/level2.tscn"
var seconds = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ScoreTimer.start()
	$trapdoorN.play()
	$music.play()
	$HUD.update_level("Level 2.5")
	$HUD/HBoxContainer/key1.visible=false
	$HUD/keynum.visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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



func _on_ladder_body_entered(body: Node2D) -> void:
	
	$HUD.show_message("Oh no the Latch locked!!")



func _on_door_body_entered(body: Node2D) -> void:
	_load_next_scene()


func _on_statue_body_entered(body: Node2D) -> void:
	
	$HUD.show_message("Here marks the hero of all the land")
	await get_tree().create_timer(1.5).timeout
	$HUD.show_message("It's a spitting image of my Father!?!")
	await get_tree().create_timer(1.5).timeout


func _on_pedistal_body_entered(body: Node2D) -> void:
	
	$HUD.show_message("Seems that something is missing?")
	await get_tree().create_timer(1.5).timeout
	$HUD.show_message("I wonder why Dad never mentioned this?")

func _on_wall_message_body_entered(body: Node2D) -> void:
	
	$HUD.show_message("The road ahead is not for the faint of heart")
	await get_tree().create_timer(1.5).timeout
	$HUD.show_message("This is the path to the Stone Bridge")


func _on_score_timer_timeout() -> void:
	seconds += 1
