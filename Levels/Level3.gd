extends "res://Levels/BaseLevel.gd"

var next_level = "res://Levels/Level1.tscn"

func _ready():
	._ready()

func _on_SceneChangerTester__time_to_change_level_player2():
	SceneChanger.change_scene(next_level)	
