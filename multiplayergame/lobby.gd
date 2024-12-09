extends Control

const ADDRESS = "localhost"#"game.wcpc.fun"
const PORT = 3001

@export_file("*.tscn") var arena_screen_scene = "res://character_selection.tscn"

@onready var user_line_edit = $UserLineEdit
@onready var password_line_edit = $PasswordLineEdit
@onready var error_label = $ErrorLabel
@onready var login_button = $LoginButton
@onready var start_button = $StartButton
@onready var logged_players_label = $LoggedPlayersColorRec/Label

var peer = ENetMultiplayerPeer.new()


func _ready():
	peer.create_client(ADDRESS, PORT)
	print("Connected")
	multiplayer.multiplayer_peer = peer
	
	error_label.text = "Insert username and password"
	user_line_edit.grab_focus()


func _on_UserLineEdit_text_submitted(new_text):
	if not password_line_edit.text == "":
		send_credentials()
	else:
		error_label.text = "Insert password"
		password_line_edit.grab_focus()


func _on_PasswordLineEdit_text_submitted(new_text):
	if not user_line_edit.text == "":
		send_credentials()
	else:
		error_label.text = "Insert username"
		user_line_edit.grab_focus()


func _on_LoginButton_pressed():
	if user_line_edit.text == "":
		error_label.text = "Insert username"
		user_line_edit.grab_focus()
	elif password_line_edit.text == "":
		error_label.text = "Insert password"
		password_line_edit.grab_focus()
	else:
		print("Works")
		send_credentials()

@rpc("any_peer","call_remote")
func send_credentials():
	var user = user_line_edit.text
	var password = password_line_edit.text
	rpc_id(get_multiplayer_authority(), "authenticate_player", user, password)
	print("sending credentials")

@rpc("any_peer","call_remote")
func authenticate_player(user, password):
	pass


@rpc
func authentication_failed(error_message):
	error_label.text = error_message


@rpc
func authentication_succeed(session_token):
	print("successfull login")
	error_label.text = "Login successful!!"
	AuthenticationCredentials.user = user_line_edit.text
	AuthenticationCredentials.session_token = session_token
	user_line_edit.hide()
	password_line_edit.hide()
	login_button.hide()
	start_button.show()
	start_button.grab_focus()


func _on_StartButton_pressed():
	rpc_id(get_multiplayer_authority(), "start_game")


@rpc
func add_logged_player(player_name):
	print("works")
	logged_players_label.text = logged_players_label.text + "\n%s" % player_name

@rpc
func clear_logged_players():
	logged_players_label.text = "Players in match: \n \n"


@rpc("any_peer", "call_remote")
func start_game():
	get_tree().change_scene_to_file(arena_screen_scene)
