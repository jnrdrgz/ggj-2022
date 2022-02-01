extends Node2D

onready var anim_player = $AnimationPlayer
onready var attack_timer = $AttackTimer
export (bool) var can_kill = true
export (int) var time1 = 6
export (int) var time2 = 3

var time_attack_1 = true
var time_attack_2 = false

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
func _ready():
	anim_player.play("idle")
	attack_timer.set_wait_time(time1)
	attack_timer.start()
 
func _process(delta):
	pass
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.kill()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		play_anim("idle")


func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		anim_player.play("attack")
		#if can_kill:
		#	body.kill()


func _on_AttackTimer_timeout():
	anim_player.play("attack")
	if time_attack_1:
		attack_timer.set_wait_time(time2)
		time_attack_1 = false
		time_attack_2 = true
		attack_timer.start()
	if time_attack_2:
		attack_timer.set_wait_time(time1)
		time_attack_1 = true
		time_attack_2 = false
		attack_timer.start()
