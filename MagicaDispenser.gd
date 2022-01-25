extends Node2D

var dropping_objects = false
var already_open = false

onready var magicalObjectScenePath = "res://MagicalFlyingObject.tscn"

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

func _ready():
	pass # Replace with function body.

func _process(delta):
	if(dropping_objects):
		pass

func throw_magical_object():
	var object = load(magicalObjectScenePath)
	var mo = object.instance()
	add_child(mo)
	mo.global_position = global_position
	mo.scale = Vector2(0.5,0.5)
	#mo.go_to_player()

func _on_OpenArea_body_entered(body):
	if body.is_in_group("player") and not already_open:
		play_anim("shake_and_open")
		already_open = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "shake_and_open":
		dropping_objects = true
		throw_magical_object()
