extends KinematicBody2D

export (int) var speed = 200
export (int) var climbing_speed = 200
export (int) var jump_speed = -1200
export (int) var gravity = 1500
export (float) var plus_time_action = 1.0
export (bool) var player2 = false
var player = null

var is_in_ladder = false
var velocity = Vector2.ZERO
var delay = 0.5

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

func _ready():
	#$Camera2D.global_position.x = global_position.x - 50
	#$Camera2D.global_position.y = global_position.y
	#if player2:
	#	$Camera2D.current = false
		#$Camera2D.queue_free()
	player = get_parent().get_node("Player")

func _physics_process(delta):
	get_recording()
	pass
	
func get_recording():
	action_count += 1
	var test = player.player_movements_queue_all.pop_back()#load_data.get(String(count))
	yield(get_tree().create_timer(3), "timeout")
	if(test != null):
		#print(test[1])
		play_anim(test[0])
		global_position = test[1]
		sprite.flip_h = test[2]
		sprite.flip_v = test[3]
		

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		yield(get_tree().create_timer(delay), "timeout")
		#if player2:
		#	yield(get_tree().create_timer(0.5), "timeout")
		velocity.x += speed
		if !is_in_ladder:
			play_anim("walking")
			sprite.flip_h = false
	elif Input.is_action_pressed("walk_left"):
		yield(get_tree().create_timer(delay), "timeout")
		velocity.x -= speed
		if !is_in_ladder:
			play_anim("walking")
			sprite.flip_h = true
	elif Input.is_action_pressed("up_arrow"):
		yield(get_tree().create_timer(delay), "timeout")
		if is_in_ladder:
			velocity.y = -climbing_speed
			play_anim("climbing")
	elif Input.is_action_pressed("down_arrow"):
		yield(get_tree().create_timer(delay), "timeout")
		if is_in_ladder:
			velocity.y = climbing_speed
			play_anim("climbing")
		if is_on_floor():
			play_anim("downing")
		
		
func _physics_process_back(delta):
	velocity.x = 0
	if player:
		if len(player.player_movements_queue) != 0 and next_action_to_excute == null:
			var act = player.pop_front_action()
			yield(get_tree().create_timer(delay), "timeout")
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


func _on_ActionTimer_timeout():
	print("time")
	next_action_to_excute = null
