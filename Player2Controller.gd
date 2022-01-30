extends Control

var player_movements_queue = []
var action_time = 0
var has_to_update_text = false


signal derecha_button_pressed_signal()

func _ready():
	pass # Replace with function body.

func process(delta):
	#if has_to_update_text:
	#	update_text()
	pass
	
func update_text():
	var new_t: String = ""
	for t in player_movements_queue:
		new_t += t[0] + str(t[1]) + "\n"
	
	$Player2Actions.text = new_t
	
func update_queue(action):
	action_time = OS.get_ticks_msec() - action_time
	if action == "jump": action_time = 0.1
	player_movements_queue.append([action, action_time])
	update_text()
	#print(player_movements_queue)	

func _on_DerechaButton_button_down():
	action_time = OS.get_ticks_msec()
	#spawn_dialog(get_global_mouse_pos())
	#emit_signal("derecha_button_pressed_signal")
	print("DERECHA DOWN")	

func _on_DerechaButton_button_up():
	update_queue("walk_right")
	
func _on_SaltarButton_button_down():
	update_queue("jump")
	
func _on_AgacharButton_button_down():
	action_time = OS.get_ticks_msec()
	print("down DOWN")	

func _on_IzquierdaButton_button_down():
	action_time = OS.get_ticks_msec()
	has_to_update_text = true

func _on_AgacharButton_button_up():
	update_queue("arrow_down")

func _on_IzquierdaButton_button_up():
	update_queue("walk_left")
	has_to_update_text = false

func _on_GoButton_pressed():
	print(get_parent().get_parent().get_node("Player2").set_object_queue(player_movements_queue))
	player_movements_queue.clear()
