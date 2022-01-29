extends "res://Levels/BaseLevel.gd"

var next_level = "res://Cutscenes/AfterLevel2.tscn"

func _ready():
	._ready()

func _on_SceneChangerTester__time_to_change_level():
	SceneChanger.change_scene(next_level)	
