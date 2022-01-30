extends Node2D

enum aitype_enum {NONE, SEEK, ARRIVE, STAYWALLS, FOLLOWPATH}
enum spritetype_enum {
	TAPE,TOOL,KEY,SODA,CAFE,CHOCOLATE,COKE,HAMB,
	JUICE,FRIES,MEDAL,MEDAL,HOTDOG,ICECREAM,GIFT,COFFEE,PICTUREMAM,PICTURECASTLE}
enum magicaldispensertype_enum {LIBRARY,COFFIN,FRIDGE}

var lvl1_start_pos = Vector2.ZERO
var lvl2_start_pos = Vector2.ZERO
var lvl3_start_pos = Vector2.ZERO
