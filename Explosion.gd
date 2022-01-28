extends Node2D

var finished = false
onready var anim_player = $AnimationPlayer

func _ready():
	pass # Replace with function body.

func _on_AnimationPlayer_animation_finished(anim_name):
	finished = true	

func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
