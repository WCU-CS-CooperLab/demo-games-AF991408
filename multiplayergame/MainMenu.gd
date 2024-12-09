extends Control

@export_file("*.tscn") var server_scene = "res://server.tscn"
@export_file("*.tscn") var lobby_scene = "res://lobby.tscn"

func _on_server_button_pressed() -> void:
	get_tree().change_scene_to_file(server_scene)

func _on_client_button_pressed() -> void:
	get_tree().change_scene_to_file(lobby_scene)
