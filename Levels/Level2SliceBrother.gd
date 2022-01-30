extends Node2D

var next_level = "res://Cutscenes/AfterLevel1.tscn"
var start_position = global_position

var player_arrive = false
var player2_arrive = false

signal arrived()

func _ready():
	start_position = global_position
	if Globals.lvl2_start_pos != Vector2.ZERO:
		$Player.global_position = Globals.lvl2_start_pos
		
func _process(delta):
	if player_arrive and player2_arrive:
		print("two arrive")

func _on_SceneChangerTester__time_to_change_level():
	SceneChanger.change_scene(next_level)

func _on_Player_player_dead():
	SceneChanger.change_scene("res://Levels/Level2SliceBrother.tscn")


func _on_Checkpoint_checkpoint_touched(pos):
	Globals.lvl2_start_pos = pos

func _on_Checkpoint2_checkpoint_touched(pos):
	Globals.lvl2_start_pos = pos
