extends StaticBody2D

enum colorenum {RED,BLUE}
export (colorenum) var color = colorenum.RED

func _ready():
	if color == colorenum.RED:
		$blue.hide()
		$red.show()
	if color == colorenum.BLUE:
		$blue.show()
		$red.hide()
		
