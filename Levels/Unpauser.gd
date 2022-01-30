extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("play_slice_1"):
		get_tree().paused = false
		get_parent().get_node("ViewportContainer").pause_mode = PAUSE_MODE_PROCESS
		get_parent().get_node("ViewportContainer2").pause_mode = PAUSE_MODE_INHERIT
		get_tree().paused = true
		Physics2DServer.set_active(true)
	if Input.is_action_just_pressed("play_slice_2"):
		get_tree().paused = false
		get_parent().get_node("ViewportContainer2").pause_mode = PAUSE_MODE_PROCESS
		get_parent().get_node("ViewportContainer").pause_mode = PAUSE_MODE_INHERIT
		get_tree().paused = true
		Physics2DServer.set_active(true)
