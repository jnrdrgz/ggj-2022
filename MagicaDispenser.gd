extends Node2D

var dropping_objects = false
var already_open = false

onready var magicalObjectScenePath = "res://MagicalFlyingObjectInherited.tscn"

signal finished_throwing()
signal start_throwing()

onready var textures = {
		Globals.magicaldispensertype_enum.LIBRARY: load("res://Assets/sprChest_0-Sheet.png"),
		Globals.magicaldispensertype_enum.FRIDGE: load("res://Assets/sprFridge_1-Sheet.png"),
		Globals.magicaldispensertype_enum.COFFIN: load("res://Assets/sprChest_0-Sheet.png"),}

onready var objects_can_throw = {
		Globals.magicaldispensertype_enum.LIBRARY: [],
		Globals.magicaldispensertype_enum.FRIDGE: [Globals.spritetype_enum.HAMB, Globals.spritetype_enum.SODA],
		Globals.magicaldispensertype_enum.COFFIN: [Globals.spritetype_enum.TAPE, Globals.spritetype_enum.MEDAL, Globals.spritetype_enum.COFFEE],}

export (int) var max_objects
export (int) var time_between_objects = 4
export (int) var object_per_throw = 1
export (Globals.magicaldispensertype_enum) var dispenser_type = Globals.magicaldispensertype_enum.COFFIN
var throwed_objects = 0
var rng = RandomNumberGenerator.new()

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
	$Sprite.texture = textures[dispenser_type]

func _process(delta):
	if(dropping_objects):
		pass

func throw_magical_object():
	rng.randomize()
	var rn_object_index = rng.randi_range(0,len(objects_can_throw[dispenser_type])-1)
	#print("ln", len(objects_can_throw[dispenser_type]), objects_can_throw)
	
	var object = load(magicalObjectScenePath)
	var mo = object.instance()
	add_child(mo)
	mo.global_position = global_position
	#mo.set_ai(Globals.aitype_enum.SEEK)
	#mo.set_type()
	mo.scale = Vector2(0.5,0.5)
	mo.set_texture(objects_can_throw[dispenser_type][rn_object_index])
	#mo.go_to_player()
	dispense_timer.start()

func _on_OpenArea_body_entered(body):
	if body.is_in_group("player") and not already_open:
		play_anim("shake_and_open")
		already_open = true
		emit_signal("start_throwing")


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
			yield(get_tree().create_timer(time_between_objects/object_per_throw), "timeout")
		if throwed_objects == max_objects:
			emit_signal("finished_throwing")
