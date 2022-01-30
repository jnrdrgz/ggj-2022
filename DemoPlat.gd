extends StaticBody2D

enum colorenum {RED,BLUE,TRANS}
export (colorenum) var color = colorenum.RED
export (bool) var deactivated = false

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

	if deactivated:
		deactivate()
func _on_GraceZone_body_entered(body):
	if body.is_in_group("player"):
		body.is_in_grace_zone = true

func _on_GraceZone_body_exited(body):
	if body.is_in_group("player"):
		body.is_in_grace_zone = false

func deactivate():
	hide()
	$CollisionShape2D.call_deferred("set", "disabled", true)

func activate():
	show()
	#$CollisionShape2D.disabled = false
	$CollisionShape2D.call_deferred("set", "disabled", false)

func _on_MagicaDispenser_start_throwing():
	activate()	

func _on_MagicaDispenser_finished_throwing():
	deactivate()

func _on_MagicaDispenser3_finished_throwing():
	deactivate()
