extends Node2D

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func _ready():
	pass # Replace with function body.

func _on_OpenArea_body_entered(body):
	if body.is_in_group("player"):
		play_anim("shake_and_open")	
