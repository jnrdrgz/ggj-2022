extends KinematicBody2D

export (int) var speed = 200
export (int) var jump_speed = -1200
export (int) var gravity = 1500
export (bool) var player2 = false

var velocity = Vector2.ZERO

onready var sprite = $Sprite
onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

onready var start_position = global_position

func _ready():
	#$Camera2D.global_position.x = global_position.x - 50
	#$Camera2D.global_position.y = global_position.y
	#if player2:
	#	$Camera2D.current = false
		#$Camera2D.queue_free()
	pass
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		#if player2:
		#	yield(get_tree().create_timer(0.5), "timeout")
		velocity.x += speed
		print(speed, velocity.x)
		play_anim("walking")
		sprite.flip_h = false
	elif Input.is_action_pressed("walk_left"):

		velocity.x -= speed
		play_anim("walking")
		sprite.flip_h = true
	else:
		if is_on_floor():
			play_anim("idle")		
		
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	
	if !is_on_floor():
		play_anim("jumping")


func _on_DeathZone_body_entered(body):
	global_position = start_position
