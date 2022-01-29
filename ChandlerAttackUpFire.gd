extends Node2D

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
func _ready():
	anim_player.play("idle")
 
func _process(delta):
	pass
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		anim_player.play("attack")
		body.kill()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attack":
		play_anim("idle")
