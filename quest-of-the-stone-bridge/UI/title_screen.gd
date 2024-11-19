extends Node2D

var follow = PathFollow2D.new()

@export var speed = 150

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	$StartWait.start()

func _physics_process(delta):
	follow.progress += speed * delta
	position = follow.global_position
	if follow.progress_ratio >= 1:
		queue_free()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://level1/level1.tscn")

func _on_timer_timeout():
	$Node2D/AnimationPlayer.play("message_animation")
	await get_tree().create_timer(.5).timeout
	$Node2D/AnimationPlayer.play("message_animation_bounce")

func _on_start_wait_timeout() -> void:
	if GlobalData.save_data.high_score == 0:
		pass
	else: 
		var highscore = GlobalData.save_data.high_score
		$Highscore.text = "Quickest time: " + str(highscore) + " seconds"
