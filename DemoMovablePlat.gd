extends StaticBody2D

enum colorenum {RED,BLUE}
export (colorenum) var color = colorenum.RED
onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)
	
func _ready():
	if color == colorenum.RED:
		$CollisionShape2D/blue.hide()
		$CollisionShape2D/red.show()
	if color == colorenum.BLUE:
		$CollisionShape2D/blue.show()
		$CollisionShape2D/red.hide()

func _on_process(delta):
	anim_player.play("move")
