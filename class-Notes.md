CLass Notes
----Wednesday (8/28)----------------------------------------------
GDScript (Similar to Python)

you can use Const 
make a name for enum
you have to "call" functions 
"elif" instead of "else if"
default for a match is "_"
match param3:
3:
print("its 3")
_:
print("its not 3")

Similarities:
indentation has meaning 
self is a keyword in GDScript instead of a parameter
static typing in GDScript is an enforced version of type hints in python 3

Differences: 

func instead of def for functions
variable declaration in class instead of variable assignment in _init()
self is a keyword in GDScript instead of a parameter
GDScript has specific keywords related to Godot and the Godot editor
Every file is a class in Godot


------------------------------------------------------------------


-----------------------------------------------------------------9/9
4 elemenents of game design = aestehtics, technology, mechanics, story 

--------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------
coin dash (important stuff from each .tscn)
player = 
learned how to differentiate things into certain groups calling a different pickup for each with the _on_area_entered method we used 
ex.
	if area.is_in_group("coins"):
		area.pickup()
		pickup.emit("coin")

learned how to set AnimationSprite2d animations when doing certain tasks such as moving or staying still
ex.
  if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"

coin=
learned how to trun off collision shapes (in this case for when a coin is picked up)
ex. $CollisionShape2D.set_deferred("disabled", true)
learned how to make sure objects in differing groups don't spawn on each other 
ex. if area.is_in_group("obstacles"):
		position = Vector2(randi_range(0, screensize.x), randi_range(0, screensize.y))

Main=
learned how to export scenes into the main:
ex. @export var coin_scene : PackedScene
learned how to make stuff happen when a group item is interacted with 
ex. match type:
		"coin":
			score += 1
			$HUD.update_score(score)
			$CoinSound.play()

learned how to remove all of one group from the screen (in this case when game over)
ex. get_tree().call_group("obstacles", "queue_free")

learned how to check if all of one type of group is completely gone:
ex. if playing and get_tree().get_nodes_in_group("coins").size() == 0:


Hud=
leanred how to update the wording in a text:
ex. func update_score(value):
	$MarginContainer/Score.text = str(value)
learned how to hide and show a label 
ex. $Message.show()   $Message.hide()

Non-script important unique info
Player = learned how to use animated sprites (2d) and give collision shapes to things 
main = learned how to set a background png and add sounds to a project 
Hud = learned how to use labels , timers, and startbutton 
-------------------------------------------------------------------------------------------------------------------------------------
Golfing game= (important stuff from each .tscn)
Hole=
3d game 
learned how to have different functions or states that can change by calling a method and have different functions
ex. func change_state(new_state):
	state = new_state
	match state:
		AIM:
			$Arrow.position = $Ball.position
			$Arrow.show()

HUD=
learned how to preload pngs 
ex. "green": preload("res://assets/bar_green.png"),


Non-script important unique info
Ball= learned how to make 3d objects using Meshinstance3d and their 3dcollisionShape
Hole= learned how to use Camera3d and how it has to be placed on the game and how to use directional lighting to make it look nicer. also learned how to use gridmap to make the golf course 


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
Project 1 unique info 
learned how to turn off collision boxes on something for a few seconds:
ex. 		$Player/CollisionShape2D.disabled = true
		await get_tree().create_timer(2.0).timeout
		$Player/CollisionShape2D.disabled = false

learned how to modify player speed in script 
ex.
$Player.speed +=30

also gave the objects this time a lifetime 
ex. Kraken < AnimatedSprite2d < CollisionShape2d < Lifetime (timer)


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------]
Jungle Jump=
Learned how to set a level base use that code as a baseline to make new levels (level_base -> level_01)
learned how to use a camera 2d that follows the player in a 2d space 
leanred how to make a moving 2d background by using parallax layers and sprite 2ds
learned how to use tilesets to make entire maps for the 2d game and how to give the individual sprites on the tilesets diferent collision shapes 
learned how to make a moving enemy with them able to take damage by the player if you mario stomp them 
Biggest thing learned this project was the different way we animated the sprites of the player and the enemy 
This time we use AnimationPlayer which has different animations for each task such as "hurt, idle, run"
We use a png with multiple sprites on it then cut them up into frames then we animate each task by using frames 1-6 then the next with frames 7-8 etc.
both the player and enemy were done this way in this program


























