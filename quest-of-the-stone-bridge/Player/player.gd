extends CharacterBody2D


@export var movement_speed = 150

@export var run_speed = 250

var has_gone_downstairs = false #For level 1

enum {IDLE, RUN, WALK}
var state = IDLE

func _ready():
	change_state(IDLE)

func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			$AnimatedSprite2D.play("idel")
			$IdelCollision.disabled = false
			$RunCollision.disabled = true
			$WalkCollision.disabled = true

		RUN:
			$AnimatedSprite2D.play("run")
			movement_speed = 250
			$IdelCollision.disabled = true
			$RunCollision.disabled = false
			$WalkCollision.disabled = true
		WALK:
			$AnimatedSprite2D.play("walk")
			movement_speed = 150
			$IdelCollision.disabled = true
			$RunCollision.disabled = true
			$WalkCollision.disabled = false

func get_input():
	
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var shift = Input.is_action_just_pressed("run")
	var space = Input.is_action_just_pressed("interact")
	
	velocity.x = 0
	velocity.y = 0
	if right:
		velocity.x += movement_speed
		$AnimatedSprite2D.flip_h = false
	if left:
		velocity.x -= movement_speed
		$AnimatedSprite2D.flip_h = true
	if up:
		velocity.y -= movement_speed
	if down:
		velocity.y += movement_speed

	if right and shift:
		change_state(RUN)
	if left and shift:
		change_state(RUN)
	
	
	# IDLE transitions to WALK when moving
	if state == IDLE and velocity.x != 0:
		change_state(WALK)
	# IDLE transitions to RUN when moving
	if state == IDLE and velocity.x > 150:
		change_state(RUN)
	# RUN transitions to IDLE when standing still
	if state == RUN and velocity.x == 0:
		change_state(IDLE)
	# WALK transitions to IDLE when standing still
	if state == WALK and velocity.x == 0:
		change_state(IDLE)

func _physics_process(delta):
	
	get_input()
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		
		if collision.get_collider().is_in_group("puzzle"):
			if position.y < collision.get_collider().position.y:
				collision.get_collider().take_damage()

func reset(_position):
	position = _position
	show()
	change_state(IDLE)
