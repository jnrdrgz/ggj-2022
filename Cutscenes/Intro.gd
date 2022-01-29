extends Node2D
var next_level = "res://Levels/Level1.tscn"
onready var animation_player = $AnimationPlayer

func _ready():
	var new_dialog = Dialogic.start('intro')
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)

func dialog_listener(test):
	animation_player.play("camera_pan")
	yield(animation_player, "animation_finished")
	SceneChanger.change_scene(next_level)	

