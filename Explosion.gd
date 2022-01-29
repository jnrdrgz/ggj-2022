extends Node2D

var finished = false
onready var anim_player = $AnimationPlayer

var loop_count = 0

func _ready():
	pass # Replace with function body.

func _on_AnimationPlayer_animation_finished(anim_name):
	print(loop_count)
	loop_count += 1
	if loop_count > 3:
		finished = true	

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
