extends "res://Enemy.gd"

var right_sprite = load("res://Assets/right_dialog_box.png")

var dialog_type = "right"

func _ready():
	#._ready()
	player = get_tree().current_scene.get_node("Player2")
	$Sprite.texture = right_sprite
	.set_ai(Globals.aitype_enum.SEEK)

func _physics_process(delta):
	._physics_process(delta)
	
func _on_Area2D2_body_entered(body):
	if(body.is_in_group("player2")):
		if dialog_type == "right":
			body.mode_player_actions_queue.push_back(["walk_right", 500])
		if dialog_type == "left":
			body.mode_player_actions_queue.push_back(["walk_left", 500])
		if dialog_type == "jump":
			body.mode_player_actions_queue.push_back(["jump", 1])
		queue_free()
	
