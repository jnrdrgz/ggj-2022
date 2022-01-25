extends Area2D

var speed = 10
onready var effect = $FloatingEffect

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func _ready():
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
	pass
	
func _on__body_entered(body):
	if body.is_in_group("player"):
		#body.queue_free()
		print("object hitted plyer")
		queue_free()
	if body.is_in_group("platform"):
		queue_free()


func _on_FloatingEffect_tween_completed(object, key):
	play_anim("float_updown")
