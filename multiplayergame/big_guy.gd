extends CharacterBody2D

@export var run_speed = 100
@export var jump_speed = -700

@export var gravity = 1000
signal died
signal item_pickup


enum {IDLE, RUN, JUMP, HURT, DEAD}

var state = IDLE
var anim
var new_anim
var right = false
var left = false
var life =4
var cooldown_active=false
var has_power = false

var shield_health=0

var max_jumps = 2
var jump_count = 0

enum p_state {NONE, DOUBLEJ, SHIELD, MOREDMG}
var powerup_state = p_state.NONE

var righthit=false
var lefthit=false
func _process(delta: float) -> void:
	if life==4:
		$HUD/HBoxContainer/LifeCounter/armor1.visible=true
		$HUD/HBoxContainer/LifeCounter/armor2.visible=true
		$HUD/HBoxContainer/LifeCounter/armor3.visible=true
		$HUD/HBoxContainer/LifeCounter/armor4.visible=true
	if life==3:
		$HUD/HBoxContainer/LifeCounter/armor4.visible=false
		$HUD/HBoxContainer/LifeCounter/armor1.visible=true
		$HUD/HBoxContainer/LifeCounter/armor2.visible=true
		$HUD/HBoxContainer/LifeCounter/armor3.visible=true
	if life==2:
		$HUD/HBoxContainer/LifeCounter/armor4.visible=false
		$HUD/HBoxContainer/LifeCounter/armor1.visible=false
		$HUD/HBoxContainer/LifeCounter/armor2.visible=true
		$HUD/HBoxContainer/LifeCounter/armor3.visible=true
	if life==1:
		$HUD/HBoxContainer/LifeCounter/armor4.visible=false
		$HUD/HBoxContainer/LifeCounter/armor1.visible=false
		$HUD/HBoxContainer/LifeCounter/armor2.visible=false
		$HUD/HBoxContainer/LifeCounter/armor3.visible=true
	if life==0:
		$HUD/HBoxContainer/LifeCounter/armor4.visible=false
		$HUD/HBoxContainer/LifeCounter/armor1.visible=false
		$HUD/HBoxContainer/LifeCounter/armor2.visible=false
		$HUD/HBoxContainer/LifeCounter/armor3.visible=false

func _ready(): 
	
	hide_all_sprites(self)
	change_state(IDLE)
	
	
func start(pos):
	position=pos
	show()
	
	emit_signal('life_changed', life)
	change_state(IDLE)
	
func change_state(new_state):
	state = new_state
	match state:
		IDLE:
			hide_all_sprites(self)
			$idle.visible=true
			$AnimationPlayer.play('idle')
			$footstep.stop()
			dot_syst()

		RUN:
			hide_all_sprites(self)
			$run.visible=true
			$AnimationPlayer.play('run')
			$footstep.play()
			dot_syst()
		HURT:
			$footstep.stop()
			hide_all_sprites(self)
			$fall.visible=true
			$AnimationPlayer.play('fall')
			velocity.y=-300
			velocity.x=-100*sign(velocity.x)
			
			if powerup_state == p_state.SHIELD and\
			shield_health > 0:
				shield_health -= 1
				if shield_health <= 0:
					$Shield.hide()
			else:
				life=life-1
			print(life)
			if life <=0 :
				change_state(DEAD)
				
			else:
				await get_tree().create_timer(0.5).timeout
				change_state(IDLE)
			
			
		JUMP:
			$footstep.stop()
			hide_all_sprites(self)
			$jump.visible=true
			$AnimationPlayer.play('jump')
			dot_syst()
			
			
		DEAD:
			$footstep.stop()
			hide_all_sprites(self)
			$fall.visible=true
			$AnimationPlayer.play('fall')
			died.emit()
			$diesound.play()
			await get_tree().create_timer(1).timeout
			queue_free()
			await get_tree().create_timer(0.4).timeout
			
			died.emit()
			#await get_tree().create_timer(.2).timeout
			#if get_tree() != null:
			#	print("dead")
			#
			#	get_tree().reload_current_scene()
			#else:
			#	print("scene tree is full")
			#hide()
		#firstAT:
		#	hide_all_sprites(self)
		#	$hit1.visible=true
		#	$AnimationPlayer.play('hit1')
		#secondAT:
		#	hide_all_sprites(self)
		#	$hit2.visible=true
		#	$AnimationPlayer.play('hit2')
		#thirdAT:
		#	hide_all_sprites(self)
		#	$hit3.visible=true
		#	$AnimationPlayer.play('hit3')
			

func change_powerup_state(new_state):
	powerup_state = new_state
	has_power = true
	
	match powerup_state:
		p_state.SHIELD:
			$Shield.show()
	
func get_input():
	if state== HURT:
		return
	
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('jump')
	var firstAT = Input.is_action_pressed('firstAT')

	velocity.x=0
	#-----------------------------------------------------------movement
	if right:
		velocity.x += run_speed
		going_right()
	if left: 
		velocity.x -= run_speed
		going_left()
	if jump and is_on_floor():
		change_state(JUMP)
		velocity.y=jump_speed
		jump_count += 1
	if jump and powerup_state == p_state.DOUBLEJ and\
		not is_on_floor() and jump_count < max_jumps:
		change_state(JUMP)
		velocity.y=jump_speed/1.5
		jump_count += 1
	if state == IDLE and velocity.x !=0:
		change_state(RUN)
	if state == RUN and velocity.x == 0 :
		change_state(IDLE)
	if state in [IDLE, RUN] and !is_on_floor():
		change_state(JUMP)
	#-------------------------------------------------------attacks
	if firstAT and not cooldown_active and is_on_floor(): #j
		$footstep.stop()
		hide_all_sprites(self)
		$hit1.visible=true
		$AnimationPlayer.play('hit1')
		
		if righthit ==true:
			$hit1colarR/hit1col.disabled=false
		if lefthit ==true:
			$hit1colarL/hit1col.disabled=false
		$swing1.play()
		await get_tree().create_timer(0.2).timeout
		$bang.play()
		$explosion.play()
		#$sword1.play()#sound effect
		cooldown_active=true
		$Timer.start()
		await get_tree().create_timer(0.5).timeout
		change_state(IDLE)



		
func _physics_process(delta: float) -> void:
	velocity.y += gravity *delta
	get_input()
	
	move_and_slide()
	if state == HURT:
		return
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("danger"):
			hurt()
	if state == JUMP and is_on_floor():
		change_state(IDLE)
		jump_count = 0
	if state == JUMP and velocity.y >0:
		hide_all_sprites(self)
		$fall.visible=true
		$AnimationPlayer.play('fall')
		dot_syst()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("danger"):
			hurt()
		if collision.get_collider().is_in_group("enemies"):
			if position.y < collision.get_collider().position.y:
				collision.get_collider().take_damage()
				velocity.y= -200
			else:
				hurt()
func hurt():
	if state != HURT:
		change_state(HURT)
		
func reset(_position):
	position = _position
	show()
	change_state(IDLE)
	life=3
	
func hide_all_sprites(node):
	$hit1colarL/hit1col.disabled=true
	$hit1colarR/hit1col.disabled=true


	for child in node.get_children():
		if child is Sprite2D:
			child.visible = false
		elif child.get_child_count() > 0:
			hide_all_sprites(child)  # Recursively check children

func going_right():
	$idle.flip_h=false
	$run.flip_h=false
	$jump.flip_h=false
	$fall.flip_h=false
	$hit1.flip_h=false
	left=false
	right=true
	righthit=true
	lefthit=false

func going_left():
	$idle.flip_h=true
	$run.flip_h=true
	$jump.flip_h=true
	$fall.flip_h=true
	$hit1.flip_h=true

	right=false
	left=true
	righthit=false
	lefthit=true

func dot_syst():
		if right == true:
			$rightdot.visible=true
		if left == true:
			$leftdot.visible=true

func _on_timer_timeout() -> void:
	cooldown_active=false
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("danger"):
		print("big guy struck")
		hurt()
	pass # Replace with function body.


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	if area.is_in_group("danger"):
		print("big guy struck")
		hurt()
	pass # Replace with function body.

@rpc("any_peer", "call_local")
func setup_multiplayer(player_id):
	set_multiplayer_authority(player_id)
	var is_player = str(player_id) == str(name)
	set_physics_process(is_player)
	set_process_unhandled_input(is_player)
