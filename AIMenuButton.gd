extends Button

signal buttonpressed_changeai

func _on_AIMenuButton_pressed():
	emit_signal("buttonpressed_changeai")
