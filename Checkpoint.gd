extends Node2D

export (Globals.spritetype_enum) var sprite_type = Globals.spritetype_enum.PICTURECASTLE

onready var textures = {
	Globals.spritetype_enum.PICTURECASTLE: load("res://Assets/32x32_2.png"),
	Globals.spritetype_enum.PICTUREMAM: load("res://Assets/sprLadyPictureBig.png"),
}

signal checkpoint_touched(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = textures[sprite_type]
	if sprite_type == Globals.spritetype_enum.PICTUREMAM:
		$Sprite.scale = Vector2(0.5,0.5)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("checkpoint_touched", global_position)
