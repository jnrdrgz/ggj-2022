extends Node2D

onready var music = $Music
onready var cut_music = $CutMusic
onready var back_in_time = $BackInTime
onready var die = $DieSound

var sound_enabled = true

func _ready():
	pass
	
func play(name):
	if sound_enabled:
		if name == "music" and not music.playing:
			music.play()
		if name == "cut_music" and not cut_music.playing:
			cut_music.play()
		if name == "back_in_time" and not back_in_time.playing:
			back_in_time.play()
		if name == "die" and not die.playing:
			die.play()
	
func stop(name):
	if sound_enabled:
		if name == "music" and music.playing:
			music.stop()
		if name == "cut_music" and cut_music.playing:
			cut_music.stop()
		
