extends Node2D

var dropping_objects = false
var already_open = false

onready var magicalObjectScenePath = "res://MagicalFlyingObjectInherited.tscn"

export (int) var max_objects
export (int) var time_between_objects = 4
export (int) var object_per_throw = 1
var throwed_objects = 0

#export (int) var dispenser_type
#var posible_types

onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

onready var dispense_timer = $DispenseAnotherTimer

func _ready():
	dispense_timer.set_wait_time(time_between_objects)

func _process(delta):
	if(dropping_objects):
		pass

func throw_magical_object():
	var object = load(magicalObjectScenePath)
	var mo = object.instance()
	add_child(mo)
	mo.global_position = global_position
	#mo.set_ai(Globals.aitype_enum.SEEK)
	#mo.set_type()
	mo.scale = Vector2(0.5,0.5)
	#mo.go_to_player()
	dispense_timer.start()

func _on_OpenArea_body_entered(body):
	if body.is_in_group("player") and not already_open:
		play_anim("shake_and_open")
		already_open = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "shake_and_open":
		dropping_objects = true
		throw_magical_object()


func _on_DispenseAnotherTimer_timeout():
	for i in range(object_per_throw):
		if max_objects != 0 and max_objects > throwed_objects:
			throw_magical_object()
			throwed_objects += 1
			#yield timer
