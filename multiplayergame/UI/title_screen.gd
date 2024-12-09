extends Node2D

@export var speed = 150

func _ready() -> void:
	GlobalSongPlayer.play_song(load("res://UI/Battle Against The Traitor.wav"))
	
	# Start animations
	$AnimationPlayer.play("fly_in")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("title")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("bounce")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("bounce2")
	
	$Leaderboard/HBoxContainer/LineEdit.hide()


func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://lore.tscn")
