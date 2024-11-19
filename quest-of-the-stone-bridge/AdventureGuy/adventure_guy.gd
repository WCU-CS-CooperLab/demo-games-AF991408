extends CharacterBody2D

@export var run_speed = 150
var player_time: float = 0.0
enum PlayerState {IDLE_UP, IDLE_DOWN, IDLE_LEFT, 
			IDLE_RIGHT,IDLE_UP_RIGHT, IDLE_UP_LEFT, WALK_UP, WALK_DOWN, WALK_RIGHT, WALK_LEFT,
			WALK_UP_RIGHT, WALK_UP_LEFT}
var state = PlayerState.IDLE_RIGHT

var has_gone_downstairs = false

func _ready() -> void:
	change_state(PlayerState.IDLE_RIGHT)

# Movement states for the character
func change_state(new_state):
	state = new_state
	match state:
		PlayerState.IDLE_RIGHT:
			$AnimationPlayer.play("idle_right")
		PlayerState.IDLE_LEFT:
			$AnimationPlayer.play("idle_left")
		PlayerState.IDLE_UP:
			$AnimationPlayer.play("idle_up")
		PlayerState.IDLE_DOWN:
			$AnimationPlayer.play("idle_down")
		PlayerState.WALK_RIGHT:
			$AnimationPlayer.play("walk_right")
		PlayerState.WALK_LEFT:
			$AnimationPlayer.play("walk_left")
		PlayerState.WALK_UP:
			$AnimationPlayer.play("walk_up")
		PlayerState.WALK_DOWN:
			$AnimationPlayer.play("walk_down")
		PlayerState.WALK_UP_RIGHT:
			$AnimationPlayer.play("walk_right_up")
		PlayerState.WALK_UP_LEFT:
			$AnimationPlayer.play("walk_left_up")
		PlayerState.IDLE_UP_RIGHT:
			$AnimationPlayer.play("idle_up_right")
		PlayerState.IDLE_UP_LEFT:
			$AnimationPlayer.play("idel_up_left")
			
	# Checks to see if the player is in any of the Idle states, chooses correct sprite
	if new_state in [PlayerState.IDLE_UP, PlayerState.IDLE_DOWN, 
					PlayerState.IDLE_LEFT, PlayerState.IDLE_RIGHT,
					PlayerState.IDLE_UP_RIGHT, PlayerState.IDLE_UP_LEFT]:
		$IdleSprite2D.show()
		$WalkSprite2d.hide()
	else:
		$IdleSprite2D.hide()
		$WalkSprite2d.show()

func get_input():
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var inputs = [right, left, up, down]
	velocity = Vector2.ZERO
	
	#checking for diagonal movement
	if right and up:
		velocity.x += run_speed
		velocity.y -= run_speed
		change_state(PlayerState.WALK_UP_RIGHT)
	elif right and down:
		velocity.x += run_speed
		velocity.y += run_speed
		change_state(PlayerState.WALK_RIGHT)
	elif left and up:
		velocity.x -= run_speed
		velocity.y -= run_speed
		change_state(PlayerState.WALK_UP_LEFT)
	elif left and down:
		velocity.x -= run_speed
		velocity.y += run_speed
		change_state(PlayerState.WALK_LEFT)

	# checks for normal movement
	elif right:
		velocity.x += run_speed
		change_state(PlayerState.WALK_RIGHT)
	elif left:
		velocity.x -= run_speed
		change_state(PlayerState.WALK_LEFT)
	elif up:
		velocity.y -= run_speed
		change_state(PlayerState.WALK_UP)
	elif down:
		velocity.y += run_speed
		change_state(PlayerState.WALK_DOWN)
		
	var all_false = not inputs.all(func(value): return not value)

	# go to idle state depending on position
	
	if velocity == Vector2.ZERO:
		
		if state in [PlayerState.WALK_UP, PlayerState.IDLE_UP]:
			change_state(PlayerState.IDLE_UP)
		elif state in [PlayerState.WALK_RIGHT, PlayerState.IDLE_RIGHT]:
			change_state(PlayerState.IDLE_RIGHT)
		elif state in [PlayerState.WALK_LEFT, PlayerState.IDLE_LEFT]:
			change_state(PlayerState.IDLE_LEFT)
		elif state in [PlayerState.WALK_DOWN, PlayerState.IDLE_DOWN]:
			change_state(PlayerState.IDLE_DOWN)
		elif state in [PlayerState.WALK_UP_LEFT, PlayerState.IDLE_UP]:
			change_state(PlayerState.IDLE_UP_LEFT)
		elif state in [PlayerState.WALK_UP_RIGHT, PlayerState.IDLE_UP]:
			change_state(PlayerState.IDLE_UP_RIGHT)


func _physics_process(delta: float):
	get_input()
	move_and_slide()
	player_time+=delta
	

func reset(_position):
	position = _position
	show()
	change_state(PlayerState.IDLE_RIGHT)
