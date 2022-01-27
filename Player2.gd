extends KinematicBody2D

export (int) var speed = 200
export (int) var climbing_speed = 200
export (int) var jump_speed = -450
export (int) var gravity = 1500
export (float) var plus_time_action = 1.0
export (bool) var player2 = false
var player = null

var is_in_ladder = false
var velocity = Vector2.ZERO
var delay = 0.5


enum mode {FOLLOW, CONTROLS, INSTRUCTIONS}

export (mode) var player2_mode = mode.FOLLOW

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
onready var start_position = global_position
var next_action_to_excute = null
var next_action_to_excute_time = 0

var action_count = 0
var mode_player_actions_queue = []

func _ready():
	#$Camera2D.global_position.x = global_position.x - 50
	#$Camera2D.global_position.y = global_position.y
	#if player2:
	#	$Camera2D.current = false
		#$Camera2D.queue_free()
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if Input.is_action_pressed("player2_mode_follow"):
		player2_mode = mode.FOLLOW
	if Input.is_action_pressed("player2_mode_instructions"):
		player2_mode = mode.INSTRUCTIONS
	if Input.is_action_pressed("player2_mode_controls"):
		player2_mode = mode.CONTROLS

		
	if player2_mode == mode.FOLLOW:
		get_recording()
	if player2_mode == mode.CONTROLS:
		_physics_process_user_control(delta)
	if player2_mode == mode.INSTRUCTIONS:
		_physics_process_back(delta)
			
func get_recording():
	action_count += 1
	var test = player.player_movements_queue_all.pop_back()#load_data.get(String(count))
	yield(get_tree().create_timer(1.5), "timeout")
	if(test != null):
		#print(test[1])
		var space = 0
		play_anim(test[0])
		sprite.flip_h = test[2]
		sprite.flip_v = test[3]
		global_position = test[1]
		
		#if sprite.flip_h:
		#	space = 24+2
		#else:
		#	space = -(24+2)
		
		#if(test[0] == "idle" or !test[0]):
		#	global_position = Vector2(test[1].x+space, test[1].y)
		#if(test[0] == "climbing_idle"):
		#	global_position = Vector2(test[1].x, test[1].y+space)
		#else:
		#	global_position = Vector2(test[1].x, test[1].y)

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		velocity.x += speed
		if !is_in_ladder:
			play_anim("walking")
			sprite.flip_h = false
	elif Input.is_action_just_released("walk_right"):
		pass
		
	elif Input.is_action_pressed("walk_left"):
		velocity.x -= speed
		if !is_in_ladder:
			play_anim("walking")
			sprite.flip_h = true
	elif Input.is_action_just_released("walk_left"):
		pass
		
	elif Input.is_action_pressed("up_arrow"):
		if is_in_ladder:
			velocity.y = -climbing_speed
			play_anim("climbing")
	elif Input.is_action_pressed("down_arrow"):
		if is_in_ladder:
			velocity.y = climbing_speed
			play_anim("climbing")
		if is_on_floor():
			play_anim("downing")
	else:
		if is_in_ladder:
			velocity.y = 0
			play_anim("climbing_idle")
		if is_on_floor():
			play_anim("idle")	
func _physics_process_user_control(delta):
	get_input()
	if(!is_in_ladder):
		velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			#player_movements_queue.push_back(["jump", 0.1])
			velocity.y = jump_speed
			#jump_action_in_queue = true
			#var time_in_action = OS.get_ticks_msec() - time_in_action_jump
		
	elif Input.is_action_just_released("jump"):
		#var time_in_action_jump = OS.get_ticks_msec() - action_time
		#action_time_tigrered = false
		pass
		
	if !is_on_floor() and !is_in_ladder:
		if !is_in_ladder:
			play_anim("jumping")
		
func _physics_process_back(delta):
	velocity.x = 0
	#if player:
	if len(mode_player_actions_queue) != 0 and next_action_to_excute == null:
		var act = mode_player_actions_queue.pop_front()
		#yield(get_tree().create_timer(delay), "timeout")
		next_action_to_excute = act[0]
		next_action_to_excute_time = float(act[1])
		$ActionTimer.set_wait_time((next_action_to_excute_time/1000.0)*plus_time_action)
		$ActionTimer.one_shot = true
		$ActionTimer.start()
	
	if next_action_to_excute:
		if next_action_to_excute == "walk_right":
			#print($ActionTimer.time_left)
			velocity.x += speed
			if !is_in_ladder:
				play_anim("walking")
				sprite.flip_h = false
		if next_action_to_excute == "walk_left":
			#print($ActionTimer.time_left)
			velocity.x -= speed
			if !is_in_ladder:
				play_anim("walking")
				sprite.flip_h = true
	else:
		if is_in_ladder:
			velocity.y = 0
			play_anim("climbing_idle")
		if is_on_floor():
			play_anim("idle")
				
			#print($ActionTimer.time_left)
	
	
	#get_input()
	if(!is_in_ladder):
		velocity.y += gravity * delta
	
	velocity = move_and_slide(velocity, Vector2.UP)
	if next_action_to_excute:
		if next_action_to_excute == "jump":
			if is_on_floor():
				velocity.y = jump_speed
				next_action_to_excute = null
	
	if !is_on_floor() and !is_in_ladder:
		if !is_in_ladder:
			play_anim("jumping")
			

func set_is_in_ladder(b):
	is_in_ladder = b

func _on_DeathZone_body_entered(body):
	global_position = start_position

func set_object_queue(q: Array):
	for act in q:
		mode_player_actions_queue.append(act)

func _on_ActionTimer_timeout():
	print("time")
	next_action_to_excute = null

func respawn():
	global_position = start_position


