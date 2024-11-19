extends CanvasLayer

var title_screen = "res://UI/title_screen.tscn"



func _on_back_to_title_button_pressed():
	get_tree().change_scene_to_file("res://UI/title_screen.tscn")



func _on_resume_button_pressed():
	self.visible = false
