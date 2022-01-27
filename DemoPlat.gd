extends StaticBody2D

enum colorenum {RED,BLUE,TRANS}
export (colorenum) var color = colorenum.RED

func _ready():
	if color == colorenum.RED:
		$blue.hide()
		$red.show()
	if color == colorenum.BLUE:
		$blue.show()
		$red.hide()
	if color == colorenum.TRANS:
		$red.hide()
		$blue.hide()

func _on_GraceZone_body_entered(body):
	if body.is_in_group("player"):
		body.is_in_grace_zone = true

func _on_GraceZone_body_exited(body):
	if body.is_in_group("player"):
		body.is_in_grace_zone = false
