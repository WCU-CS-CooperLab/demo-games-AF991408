extends Node2D
var key =0
var skanswer = "trombone"
var skanswer2 = "Trombone"
var skanswer3 = "TROMBONE"
var skelkey=1
var chestkey=1
var farmerkey=1
var farmerpoints=1
var seconds = 0

var fanswer = "6"
@export var line_edit_node: NodePath
#@onready var input = $LineEdit
#@onready var feedback = $Feedbac
func _ready():
	$ScoreTimer.start()
	$LineEdit.visible=false
	$LineEdit2.visible=false
	$backgroundmusic.play()
	$HUD.update_level("Level 3")
	await get_tree().create_timer(1).timeout
	$doorclose.play()
	
#func _process(delta: float):
	#$HUD.update_timer("Time: %.2f" % $AdventureGuy.player_time)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if $PauseMenu.visible:
			$PauseMenu.visible = false
		else:
			$PauseMenu.visible = true




func _on_skeleton_body_entered(body: Node2D) -> void:
	if body.name == "AdventureGuy":
		if skelkey ==1:
			
			$skeltalk.play()
			$HUD.show_message("What is a skeleton's favorite instrument?")
			$LineEdit.visible=true
			$LineEdit.grab_focus()
		else:
			$skeltalk.play()
			$HUD.show_message("This isn't a charity pal")
		

		
func _on_skeleton_body_exited(body: Node2D) -> void:
	$LineEdit.visible=false
	$LineEdit.release_focus()
	

func _on_line_edit_text_submitted(submit) -> void:
	if submit == skanswer || submit == skanswer2 || submit == skanswer3:
		$skeltalk.play()
		$HUD.show_message("Very Good! Here's a key")
		key +=skelkey
		skelkey=0
		$HUD.update_key(key)
		$coin.play()
		$LineEdit.visible=false
		$LineEdit.release_focus()
	else:
		$skeltalk.play()
		$HUD.show_message("No, try again...")
		


	


func _on_chest_body_entered(body: Node2D) -> void:
	if body.name == "AdventureGuy" && chestkey==1:
		key+=chestkey 
		$HUD.update_key(key)
		$coin.play()
		chestkey=0
		
		$chest/CollisionShape2D.disabled = true
	


func _on_farmer_body_entered(body: Node2D) -> void:
	if body.name == "AdventureGuy":
		if farmerpoints==1 && farmerkey==1:
			$talk.play()
			$TileMapLayer7.clear()
			$HUD.show_message("You need 3 keys to leave...")
			await get_tree().create_timer(2).timeout
			$talk.play()
			
			$HUD.show_message("I have one")
			await get_tree().create_timer(2).timeout
			$talk.play()
			
			$HUD.show_message("The maze holds one")
			await get_tree().create_timer(2).timeout
			$talk.play()
			$HUD.show_message("and that joking skeleton")
			await get_tree().create_timer(2).timeout
			$talk.play()
			$HUD.show_message("i'll give you mine")
			await get_tree().create_timer(2).timeout
			$talk.play()
			$HUD.show_message("if you tell me how many pumpkins are on my farm")
			
		if farmerpoints ==0 && farmerkey==1:
			$talk.play()
			$HUD.show_message("How many pumpkins are out there?")
			$LineEdit2.visible=true
			$LineEdit2.grab_focus()
		if farmerpoints ==0 && farmerkey ==0:
			$talk.play()
			$HUD.show_message("I already gave you my key child")


func _on_farmer_body_exited(body: Node2D) -> void:
	farmerpoints=0
	$LineEdit2.visible=false
	$LineEdit2.release_focus()



func _on_gate_2_body_entered(body: Node2D) -> void:
	if key >= 3:
		$lock.play()
		await get_tree().create_timer(2).timeout
		_load_next_scene()
		$HUD.show_message("")#teleports to next level
	if key != 3:
		$HUD.show_message("I need 3 keys to pass")
	pass # Replace with function body.


func _on_line_edit_2_text_submitted(answer) -> void:
	if  answer == fanswer :
		$talk.play()
		$HUD.show_message("Good job... here's my key")
		key +=farmerkey
		farmerkey=0
		$HUD.update_key(key)
		$coin.play()
		$LineEdit2.visible=false
		$LineEdit2.release_focus()
	else:
		$talk.play()
		$HUD.show_message("wrong, try again...")


func _on_mazetrap_body_entered(body: Node2D) -> void:
	$AdventureGuy/Camera2D.zoom = Vector2(7,7)


func _on_mazetrap_body_exited(body: Node2D) -> void:
	$AdventureGuy/Camera2D.zoom = Vector2(2,2)


func _on_chest_body_exited(body: Node2D) -> void:
	$chest/CollisionShape2D.disabled=true
	
	
	
	
func _load_next_scene():
	#GameState.player_time = $AdventureGuy.player_time
	$ScoreTimer.stop()
	GlobalData.player_time += seconds
	get_tree().change_scene_to_file("res://level4/level_4.tscn")


func _on_score_timer_timeout() -> void:
	seconds += 1
