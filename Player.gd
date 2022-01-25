extends KinematicBody2D

export (int) var speed = 200
export (int) var climbing_speed = 200
export (int) var jump_speed = -450
export (int) var gravity = 1500
export (bool) var player2 = false


var is_in_ladder = false
var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
onready var start_position = global_position

var player_movements_queue = []
var player_movements_queue_all = []
var action_time = 0
var time_in_action_jump = 0
var action_time_tigrered = false
var jump_action_in_queue = false

func _ready():
	#$Camera2D.global_position.x = global_position.x - 50
	#$Camera2D.global_position.y = global_position.y
	#if player2:
	#	$Camera2D.current = false
		#$Camera2D.queue_free()
	pass

#func action_seconds(action, seconds):

func pop_front_action():
	var act = player_movements_queue.pop_front()
	print(player_movements_queue)
	return act
	
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		if !action_time_tigrered:
			action_time = OS.get_ticks_msec()
			action_time_tigrered = true
		#if player2:
		#	yield(get_tree().create_timer(0.5), "timeout")
		velocity.x += speed
		if !is_in_ladder:
			play_anim("walking")
			sprite.flip_h = false
	elif Input.is_action_just_released("walk_right"):
		var time_in_action = OS.get_ticks_msec() - action_time
		action_time_tigrered = false
		#player_movements_queue.push_back(["walk_right", time_in_action])
		if jump_action_in_queue:
			#player_movements_queue.push_back(["jump", 0])
			jump_action_in_queue = false
			
		#print(player_movements_queue)
		
	elif Input.is_action_pressed("walk_left"):
		if !action_time_tigrered:
			action_time = OS.get_ticks_msec()
			action_time_tigrered = true

		velocity.x -= speed
		if !is_in_ladder:
			play_anim("walking")
			sprite.flip_h = true
	elif Input.is_action_just_released("walk_left"):
		var time_in_action = OS.get_ticks_msec() - action_time
		action_time_tigrered = false
		#player_movements_queue.push_back(["walk_left", time_in_action])
		if jump_action_in_queue:
			#player_movements_queue.push_back(["jump", 0])
			jump_action_in_queue = false

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

func do_record():
	#count += 1
	#save_data[String(count)] = 
	player_movements_queue_all.push_back(
		[anim_player.current_animation, global_position, sprite.flip_h, sprite.flip_v])
	#if(Input.is_action_just_pressed("ui_down")):
	#if(Input.is_action_just_pressed("ui_down")):
	#	var f := File.new()
	#	f.open("res://ghosts/" + get_tree().current_scene.name + ".json", File.WRITE)
	#	prints("Saving to", f.get_path_absolute())
	#	f.store_string(JSON.print(save_data))
	#	f.close()

		
func _physics_process(delta):
	do_record()
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
		action_time_tigrered = false
		
	if !is_on_floor() and !is_in_ladder:
		if !is_in_ladder:
			play_anim("jumping")

func set_is_in_ladder(b):
	is_in_ladder = b

func _on_DeathZone_body_entered(body):
	player_movements_queue = []
	global_position = start_position
