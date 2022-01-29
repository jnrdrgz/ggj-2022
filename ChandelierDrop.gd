extends KinematicBody2D

export (int) var gravity = 400
var velocity = Vector2.ZERO
var falling = true

func _ready():
	velocity.y = -230
	
func _physics_process(delta):
	if falling:
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
		if(global_position.y > 2000):
			queue_free()
		
