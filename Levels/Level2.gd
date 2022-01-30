extends "res://Levels/BaseLevel.gd"

func _ready():
	._ready()
	print("level 2 constructors")
	Sound.play("music")
	#$ViewportContainer.pause_mode = PAUSE_MODE_PROCESS
	get_tree().paused = true

func _input(event):
	if Input.is_action_just_pressed("play_slice_1"):
		get_tree().paused = false
		
		print("pause")
		
func _process(delta):
	if Input.is_action_just_pressed("play_slice_1"):
		get_tree().paused = false
		print("pause")
		#$ViewportContainer.pause_mode = PAUSE_MODE_INHERIT
		#$ViewportContainer2.pause_mode = PAUSE_MODE_PROCESS
		#get_tree().paused = true
	if Input.is_action_just_pressed("play_slice_2"):
		get_tree().paused = false
		$ViewportContainer.pause_mode = PAUSE_MODE_PROCESS
		$ViewportContainer2.pause_mode = PAUSE_MODE_INHERIT
		get_tree().paused = true


func _on_ViewportContainer2_mouse_entered():
	print("pause")
