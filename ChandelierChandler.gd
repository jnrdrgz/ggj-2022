extends Node2D

onready var anim_player = $AnimationPlayer
export (int) var max_drops = 2
var drops = 0

onready var attack_timer = $AttackTimer
export (int) var time1 = 6
export (int) var time2 = 3
var time_attack_1 = true
var time_attack_2 = false

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
	fd.scale = Vector2(1.25,1.25)
	drops += 1


func _ready():
	anim_player.play("idle")
	attack_timer.set_wait_time(time1)
	attack_timer.start()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if(drops < max_drops):
			call_deferred("throw_fire_drop")
			#throw_fire_drop()



func _on_AttackTimer_timeout():
	#anim_player.play("attack")
	call_deferred("throw_fire_drop")
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
