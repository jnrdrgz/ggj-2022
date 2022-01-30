extends Node2D

func _ready():
	Globals.lvl1_start_pos = Vector2.ZERO
	Globals.lvl2_start_pos = Vector2.ZERO
	Globals.lvl3_start_pos = Vector2.ZERO

func _process(delta):
	if Input.is_action_just_pressed("start"):
		SceneChanger.change_scene("res://Cutscenes/Intro.tscn")
