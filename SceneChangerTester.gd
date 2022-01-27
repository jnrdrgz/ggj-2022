extends Node2D

signal _time_to_change_level
signal _time_to_change_level_player2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("_time_to_change_level")
		#SceneChanger.change_scene("res://Levels/Level2.tscn")	
	if body.is_in_group("player2"):
		emit_signal("_time_to_change_level_player2")
	
