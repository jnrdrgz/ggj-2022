extends Node2D

var finished = false
onready var anim_player = $AnimationPlayer

var loop_count = 0

func _ready():
	play_anim("main_explosion")

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	print("finished")
	loop_count += 1
	if loop_count > 3:
		finished = true	

	#if(anim_name == "main_explosion"):


func _on_Timer_timeout():
	queue_free()
