extends Node2D
var next_level = "res://Levels/Level3.tscn"

func _ready():
	var new_dialog = Dialogic.start('afterlevel2')
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)
	Sound.stop("music")
	Sound.play("cut_music")

func dialog_listener(test):
	SceneChanger.change_scene(next_level)	

