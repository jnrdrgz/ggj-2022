extends Node2D

var next_level = "res://Cutscenes/AfterLevel1.tscn"
var start_position = global_position

var player_arrive = false
var player2_arrive = false

signal arrived()

func _ready():
	start_position = global_position

func _process(delta):
	if player_arrive and player2_arrive:
		print("two arrive")

func _on_SceneChangerTester__time_to_change_level():
	SceneChanger.change_scene(next_level)

func _on_Player_player_dead():
	$Player.global_position = start_position
	emit_signal("arrived")
