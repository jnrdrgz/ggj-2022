extends Node2D
var next_level = "res://Levels/Level1.tscn"

func _ready():
	var new_dialog = Dialogic.start('intro')
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)

func dialog_listener(test):
	SceneChanger.change_scene(next_level)	

