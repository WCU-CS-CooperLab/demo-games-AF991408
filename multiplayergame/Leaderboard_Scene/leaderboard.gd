extends Control

var p_name: String
var score = Global.score


func _on_leader_board_pressed() -> void:
	$LeaderboardUI.show()

func _on_close_pressed() -> void:
	$LeaderboardUI.hide()

func add_to_board():
	await Leaderboards.post_guest_score("multiplayergame-leaderboard-RwGo", score, Global.player_name)
	get_tree().reload_current_scene()

func _on_line_edit_text_submitted(new_text: String) -> void:
	Global.player_name = new_text
	p_name = Global.player_name
	print(p_name)
	
	Global.score += 1
	score = Global.score
	
	await Leaderboards.post_guest_score("multiplayergame-leaderboard-RwGo", score, Global.player_name)
	get_tree().reload_current_scene()
