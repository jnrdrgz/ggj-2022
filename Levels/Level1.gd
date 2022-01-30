extends "res://Levels/BaseLevel.gd"

var next_level = "res://Cutscenes/AfterLevel2.tscn"

func _ready():
	._ready()
	Sound.play("music")
	
	if Globals.lvl1_start_pos != Vector2.ZERO:
		$Player.global_position = Globals.lvl1_start_pos

func _on_SceneChangerTester__time_to_change_level():
	SceneChanger.change_scene(next_level)	

func _on_Player_player_dead():
	SceneChanger.change_scene("res://Levels/Level1.tscn")


#func k(pos):
	

func _on_Checkpoint_checkpoint_touched(pos):
	#lvl1_start_pos	
	Globals.lvl1_start_pos = pos

func _on_Checkpoint2_checkpoint_touched(pos):
	Globals.lvl1_start_pos = pos

func _on_Checkpoint4_checkpoint_touched(pos):
	Globals.lvl1_start_pos = pos

func _on_Checkpoint3_checkpoint_touched(pos):
	Globals.lvl1_start_pos = pos

func _on_Checkpoint5_checkpoint_touched(pos):
	Globals.lvl1_start_pos = pos
