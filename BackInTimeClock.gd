extends Node2D

export (int) var time_back = 2

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		Sound.play("back_in_time")
		body.go_back_in_time_clock(time_back)
		queue_free()
