extends "res://Levels/BaseLevel.gd"

var player1_arrived = false

func _ready():
	._ready()
	print("level 2 constructors")
	Sound.play("music")
	
	$ViewportContainer.pause_mode = PAUSE_MODE_PROCESS
	var new_dialog = Dialogic.start('instructionslevel2')
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)

func _process(delta):
	if player1_arrived:
		print("player1 arrived")

func dialog_listener(test):
	#SceneChanger.change_scene(next_level)
	get_tree().paused = true


func _on_Player_player_dead():
	print("player dead")
	#SceneChanger.change_scene("res://Levels/Level1.tscn")
	get_tree().change_scene("res://Levels/Level2.tscn")


func _on_SceneChangerTester__time_to_change_level():
	player1_arrived = true


func _on_Node2D_arrived():
	player1_arrived = true
