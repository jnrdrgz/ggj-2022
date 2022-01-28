extends Node2D

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
onready var fire_drop = "res://ChandelierDrop.tscn"
func throw_fire_drop():
	var object = load(fire_drop)
	var fd = object.instance()
	add_child(fd)
	fd.global_position = $FlameSpawnPoint.global_position
	#fd.
	fd.scale = Vector2(0.75,0.75)


func _ready():
	anim_player.play("idle")

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		throw_fire_drop()

