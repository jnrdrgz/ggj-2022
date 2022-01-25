extends KinematicBody2D

enum colorenum {RED,BLUE}
export (colorenum) var color = colorenum.RED
onready var anim_player = $AnimationPlayer
func play_anim(anim):
	if anim_player.current_animation == anim:
		return
	anim_player.play(anim)

var velocity = Vector2.ZERO
export (int) var speed = 30
export (int) var wait_time_to_change = 5
var direction = 1

func _ready():
	$Timer.set_wait_time(wait_time_to_change)
	if color == colorenum.RED:
		$Sprite/blue.hide()
		$Sprite/red.show()
	if color == colorenum.BLUE:
		$Sprite/blue.show()
		$Sprite/red.hide()

#func _physics_process(delta):
#	velocity.x = 0
#	velocity.x += speed*direction
#	velocity.y = 0
#	velocity = move_and_slidevelocity, Vector2.UP)

func _on_Timer_timeout():
	direction *= -1
