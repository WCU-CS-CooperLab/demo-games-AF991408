extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.make_current()
	$AdventureGuy/AnimationPlayer.play("idle_up_right")
	$AdventureGuy/AnimationPlayer.stop()
	$AudioStreamPlayer2D.play()
	set_score(GlobalData.player_time)
	
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://UI/title_screen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_score(score):
	$FinalScore.text = "Final Time: " + str(score)
	if GlobalData.save_data.high_score == 0:
		if (-1 * score) < GlobalData.save_data.high_score:
			GlobalData.save_data.high_score = GlobalData.player_time
			GlobalData.save_data.save()
	else:
		if score < GlobalData.save_data.high_score:
			GlobalData.save_data.high_score = GlobalData.player_time
			GlobalData.save_data.save()
