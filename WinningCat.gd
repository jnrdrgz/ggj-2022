extends Node2D

var next_scene = "res://Cutscenes/WinningScene.tscn"

func _on_Area2D_body_entered(body):
	if body.is_in_group("player2"):
		SceneChanger.change_scene(next_scene)	
