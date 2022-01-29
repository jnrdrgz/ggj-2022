extends Node2D

var next_level = "res://Cutscenes/AfterLevel1.tscn"

func _on_SceneChangerTester__time_to_change_level():
	SceneChanger.change_scene(next_level)
