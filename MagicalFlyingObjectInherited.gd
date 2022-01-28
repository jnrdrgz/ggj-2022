extends "res://Enemy.gd"

var speed = 10
onready var effect = $FloatingEffect

onready var anim_player = $AnimationPlayer

var updowns = 3
var has_to_chase = false

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func _ready():
	._ready()
	effect.interpolate_property(self, 'position',
		position, Vector2(position.x, position.y-30.0), 1,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	fly_above()
	
	
func _process(delta):
	#if Input.is_action_just_pressed("walk_right"):
	#	fly_above()
	pass
	
func fly_above():
	effect.start()

func go_in_direction_to_player():
	pass

func boomerang():
	pass

func _physics_process(delta):
	#position += transform.x * speed * delta
	if has_to_chase:
		._physics_process(delta)
	

func start_chasing():
	has_to_chase = true

func _on_FloatingEffect_tween_completed(object, key):
	play_anim("float_updown")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "float_updown":
		if updowns == 0:
			start_chasing()
		elif updowns > 0:
			updowns -= 1
			play_anim("float_updown")
			.set_ai(Globals.aitype_enum.SEEK)
			#print("UPDOWN", updowns)
			
