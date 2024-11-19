extends Node2D

var secret = false
var pickaxe = false
var key = false
var chickens_found = 0
var has_run = false
var seconds = 0


func _ready():
	$ScoreTimer.start()
	$HUD.update_level(4)
	$MessageTimer.stop()
	$HUD.update_level("Level 4")
	$AdventureGuy.player_time =GameState.player_time
	$AdventureGuy/Camera2D.make_current()
	$HUD.show_message("Finally, I've arrived...")
	


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $PauseMenu.visible:
			$PauseMenu.visible = false
		else:
			$PauseMenu.visible = true
	


func _on_chest_body_entered(body: Node2D) -> void:
	if body.name == "AdventureGuy":
		$chickennoise/coin.play()
		$HUD.show_message("You have obtained 'secret'")
		secret = true
		$MessageTimer.start()
		$Chest.queue_free() #Makes it so the message only plays once. Probably not the best way, but it works

func _on_pickaxe_check_body_entered(body: Node2D) -> void:
	if pickaxe:
		$TileMapLayer5.clear()
		$breaknoise.play()
	else:
		$HUD.show_message("You should not be here right now")

func _on_rem_layers_body_entered(body: Node2D) -> void:
	$TileMapLayer4.clear()
	$TileMapLayer6.clear()

func _on_message_timer_timeout() -> void:
	$HUD.show_message("Now leave from whence you came...")

func _on_chicken_body_entered(body: Node2D) -> void:
	if body.name == "AdventureGuy":
		$chickennoise.play()

		$HUD.show_message("Please find all 4 of my babies, 
							there are four in total.
							Come back for a reward.")

		if chickens_found == 4:
			foundAll()

func foundAll():
	if key == false:
		$chickennoise.play()
		$HUD.show_message("You found my babies! Take this key, 
							and head back to who sent you here")
		key = true
		$HUD.update_key(1)
	else:
		$chickennoise.play()
		$HUD.show_message("You found my babies! Take this key, 
							and head back to who sent you here")

func _on_c_friends_body_entered(body: Node2D) -> void:
	chickens_found += 1
	$chickennoise.play()
	$HUD.show_message("Found " + str(chickens_found) + " chickens")
	$CFriends.queue_free()

func _on_c_friends_2_body_entered(body: Node2D) -> void:
	chickens_found += 1
	$chickennoise.play()
	$HUD.show_message("Found " + str(chickens_found) + " chickens")
	$CFriends2.queue_free()

func _on_c_friends_3_body_entered(body: Node2D) -> void:
	chickens_found += 1
	$chickennoise.play()
	$HUD.show_message("Found " + str(chickens_found) + " chickens")
	$CFriends3.queue_free()

func _on_c_friends_4_body_entered(body: Node2D) -> void:
	chickens_found += 1
	$chickennoise.play()
	$HUD.show_message("Found " + str(chickens_found) + " chickens")
	$CFriends4.queue_free()

func _on_case_body_entered(body: Node2D) -> void:
	$HUD.show_message("Obtained the pickaxe")
	pickaxe = true
	$Case.queue_free()

func _on_wolf_body_entered(body: Node2D) -> void:
	if key:
		$dognoise.play()
		$HUD.show_message("Look closely under the bridge
							  or on the east side of 
							  to find what you need.")
	else:
		$dognoise.play()
		$TileMapLayer7.clear()
		$HUD.show_message("Go find Mother Hen, 
								she doesn't like grass")
	if secret:
		$dognoise.play()
		$HUD.show_message("Good. Leave while you can.")

func _on_door_body_entered(body: Node2D) -> void:
	if !secret and body.name == "AdventureGuy":
		_load_prev_scene()
	if secret and body.name == "AdventureGuy":
		_load_ending_scene()

func _load_prev_scene():
	$ScoreTimer.stop()
	GlobalData.player_time += seconds
	get_tree().change_scene_to_file("res://level_3.tscn")

func _load_ending_scene():
	$ScoreTimer.stop()
	GlobalData.player_time += seconds
	get_tree().change_scene_to_file("res://Ending/ending.tscn")




func _on_welcomebody_body_entered(body: Node2D) -> void:
	if body.name == "AdventureGuy":
		if has_run==true:
			return
		else:
			has_run=true
			$wind.play()
			$reveal.play()
			$HUD.show_message("The Great Stone Bridge!")
			await get_tree().create_timer(0.7).timeout
			$firstcamera.make_current()
			await get_tree().create_timer(0.7).timeout
			$secondcamera.make_current()
			await get_tree().create_timer(0.7).timeout
			$thirdcamera.make_current()
			await get_tree().create_timer(0.7).timeout
			$AdventureGuy/Camera2D.make_current()
			await get_tree().create_timer(0.3).timeout
			$wind.stop()
			$reveal.stop()
			$level4song.play()


func _on_score_timer_timeout() -> void:
	seconds += 1
