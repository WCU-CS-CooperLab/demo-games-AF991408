extends Node2D
var win =2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$blueguy/AnimatedSprite2D.visible=false
	$redguy/AnimatedSprite2D.visible=false
	$bigguy/AnimatedSprite2D.visible=false
	
	if win==1: #SET WIN VAR TO 1 IF A BLUE GUY WON
		$blueguy/AnimatedSprite2D.visible=true
	if win==2:#SET WIN VAR TO 2 IF A RED GUY WON
		$redguy/AnimatedSprite2D.visible=true
	if win==3:#SET WIN VAR TO 3 IF A BIG GUY WON
		$bigguy/AnimatedSprite2D.visible=true
	pass # Replace with function body.
	
	$Leaderboard/LeaderBoard.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
