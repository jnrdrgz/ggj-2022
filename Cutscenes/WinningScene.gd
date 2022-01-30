extends Node2D
var next_level = "res://Cutscenes/TittleScreen.tscn"

func _ready():
	var new_dialog = Dialogic.start('afterlevel3')
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)

func dialog_listener(test):
	SceneChanger.change_scene(next_level)	

