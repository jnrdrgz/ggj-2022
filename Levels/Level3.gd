extends "res://Levels/BaseLevel.gd"

var next_level = "res://Levels/Level1.tscn"

onready var expPath = "res://BubbleBoxInherited.tscn"
func spawn_dialog(position, t):
	var object = load(expPath)
	var mo = object.instance()
	mo.dialog_type = t
	add_child(mo)
	mo.global_position = position
	mo.scale = Vector2(0.25,0.25)

func _ready():
	._ready()
	Sound.play("music")
	var new_dialog = Dialogic.start('intructionslevel3')
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)

#func _process(delta):
#	get_global_mouse_position()

func _on_SceneChangerTester__time_to_change_level_player2():
	SceneChanger.change_scene(next_level)
	


func _on_Control_derecha_button_pressed():
	print(get_global_mouse_position())


func _on_DerechaButton_button_down():
	spawn_dialog(get_global_mouse_position(), "right")


func _on_SaltarButton_button_down():
	spawn_dialog(get_global_mouse_position(), "jump")


func _on_AgacharButton_button_down():
	spawn_dialog(get_global_mouse_position(), "down")


func _on_IzquierdaButton_button_down():
	spawn_dialog(get_global_mouse_position(), "left")
