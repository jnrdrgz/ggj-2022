extends Node2D

onready var music = $Music

var sound_enabled = false

func _ready():
	pass
	
func play(name):
	if sound_enabled:
		if name == "music" and not music.playing:
			music.play()
	
func stop(name):
	if sound_enabled:
		if name == "music" and music.playing:
			music.stop()
		
