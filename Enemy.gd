extends KinematicBody2D

var player = null

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var MAX_SPEED = 3
var max_speed = Vector2(MAX_SPEED,MAX_SPEED)

enum aitype_enum {NONE, SEEK, ARRIVE, STAYWALLS, FOLLOWPATH}
export (Globals.spritetype_enum) var sprite_type = Globals.spritetype_enum.SODA
export (aitype_enum) var ai_type
onready var aibutton_scene = load("res://AIMenuButton.tscn")

var debug = false
var has_to_die_in_platform = false

onready var sprite = $Sprite
onready var textures = {
	Globals.spritetype_enum.SODA: load("res://Assets/sprBottleSoda_0.png"),
	Globals.spritetype_enum.HAMB: load("res://Assets/sprHamb_1.png"),
	Globals.spritetype_enum.FRIES: load("res://Assets/sprFrenchFries_0.png"),
	Globals.spritetype_enum.JUICE: load("res://Assets/sprJuice_1.png"),
	Globals.spritetype_enum.TAPE: load("res://Assets/sprTape0_1.png"),
	Globals.spritetype_enum.MEDAL: load("res://Assets/sprMedal_0.png"),
	Globals.spritetype_enum.HOTDOG : load("res://Assets/sprHotDog_0.png"),
	Globals.spritetype_enum.ICECREAM : load("res://Assets/sprIceCream_0.png"),
	Globals.spritetype_enum.GIFT : load("res://Assets/sprGift_0.png"),
	Globals.spritetype_enum.COFFEE : load("res://Assets/sprCafe_1.png"),
}
		
func limit(vector : Vector2, _max : float):
	var mSq = vector.length_squared()
	var nv = vector
	if (mSq > _max * _max):
		nv = vector / sqrt(mSq)*_max
	
	return nv;


func rotate_to_player():
	if player:
		var vec_to_player = player.global_position - global_position
		vec_to_player = vec_to_player.normalized()

		$Sprite.global_rotation = atan2(vec_to_player.y, vec_to_player.x)+1.5708

func rotate_to_velocity():
	var v= velocity.normalized()
	$Sprite.global_rotation = atan2(v.x, v.y*-1)


func add_aibutton(text, _aitype, offset):
	var aibutton_ins = aibutton_scene.instance()
	aibutton_ins.rect_position.y += aibutton_ins.rect_size.y*offset
	aibutton_ins.text = text
	aibutton_ins.connect("pressed", self, "_on_AIButtonPressed", [_aitype])
	
	$AIMenu.add_child(aibutton_ins)

func _on_AIButtonPressed(_aitype):
	ai_type = _aitype
	
	if ai_type == aitype_enum.STAYWALLS:
		velocity = Vector2(4,3)
	
	$AIMenu.visible = !$AIMenu.visible
	
func set_ai_type_str(t : String):
	if t == "seek": ai_type = aitype_enum.SEEK
	elif t == "arrive": ai_type = aitype_enum.ARRIVE
	elif t == "stay_walls": ai_type = aitype_enum.STAYWALLS
	elif t == "follow_path": ai_type = aitype_enum.FOLLOWPATH
	else: ai_type = aitype_enum.NONE
	
func _ready():
	player = get_tree().current_scene.get_node("Player")
	max_speed = Vector2(MAX_SPEED,MAX_SPEED)
	add_aibutton("none", aitype_enum.NONE, -4)
	add_aibutton("seek", aitype_enum.SEEK ,1)
	add_aibutton("arrive", aitype_enum.ARRIVE, 4)
	add_aibutton("stay_walls", aitype_enum.STAYWALLS, 8)
	add_aibutton("follow_path", aitype_enum.FOLLOWPATH, 12)
	
	sprite.texture = textures[sprite_type]
	
func set_texture(spr_type):
	sprite.texture = textures[spr_type]
	
func set_ai(ai):
	ai_type = ai
	
	if ai_type == aitype_enum.STAYWALLS:
		velocity = Vector2(4,3)
	
func _process(delta):
	#if $Explosion.finished:
	#	queue_free()
	pass
		
func _physics_process(delta):
	#print("executing physics child")
	#magnitud
	if !player:
		return
	if ai_type == aitype_enum.NONE:
		velocity = Vector2.ZERO
		return
	if ai_type == aitype_enum.SEEK:
		seek(player.global_position)
	if ai_type == aitype_enum.ARRIVE:
		arrive(player.global_position)
	if ai_type == aitype_enum.STAYWALLS:
		boundaries()
	if ai_type == aitype_enum.FOLLOWPATH:
		follow(Vector2(0,0), Vector2(240,280), 10)
	
	
	#if MAX_SPEED >= velocity.length():
	velocity += acceleration
	#print(velocity.length())
	#print(velocity)
	move_and_collide(velocity)
	rotate_to_velocity()
	#acceleration = Vector2.ZERO
	
func seek(target):
	var desired : Vector2 = target-global_position
	desired.normalized()
	desired = desired.normalized() * MAX_SPEED
	var steer : Vector2 = desired-velocity
	#print(desired)
	#move_and_collide(desired)
	
	acceleration = steer
	
func arrive(target): 
	var desired : Vector2 = target-global_position
	
	var d = desired.length();
	# Scale with arbitrary damping within 100 pixels
	if d < 200:
		var m = range_lerp(d, 0, 200, 0, MAX_SPEED);
		desired = desired.normalized() * m;
	else: 
		desired = desired.normalized() * MAX_SPEED;
	
	var steer : Vector2 = desired-velocity
	
	acceleration = steer
	#move_and_collide(desired)

	#Steering = Desired minus Velocity
	#let steer = p5.Vector.sub(desired, this.velocity);
	#steer.limit(this.maxforce);  // Limit to maximum steering force
	#this.applyForce(steer);

func boundaries():
	var desired
	var d = 25
	var steer = acceleration
	
	var width = 150
	var height = 150
	if debug: print("velocity", velocity)
	if debug: print("global pos", global_position)
	
	var exed = false
	if global_position.x < d: 
		desired = Vector2(MAX_SPEED, velocity.y)
		#desired = createVector(this.maxspeed, this.velocity.y)
		exed = true
	elif global_position.x > width - d:
		#desired = createVector(-this.maxspeed, this.velocity.y)
		desired = Vector2(-MAX_SPEED, velocity.y)
		exed = true
		#print("entered", velocity.x)
		 
	if not exed:
		if global_position.y < d: 
			#desired = createVector(this.velocity.x, this.maxspeed);
			desired = Vector2(velocity.x,MAX_SPEED)
		elif global_position.y > height - d:
			#desired = createVector(this.velocity.x, -this.maxspeed)
			desired = Vector2(velocity.x,-MAX_SPEED)
	
	if desired:
		
		desired = desired.normalized()
		desired = desired * MAX_SPEED 
		if debug: print("desired", desired)
		#desired.x *= 1.2
		steer = desired - velocity
		
		if debug: print("steer", steer)

		var max_steer = .15
		
		steer = limit(steer, max_steer);
		#steer.limit(this.maxforce);
		#this.applyForce(steer);
	
	acceleration = steer

func getNormalPoint(p : Vector2, a : Vector2, b : Vector2):
	#Vector from a to p
	var ap = p - a
	#Vector from a to b
	var ab = b - a
	ab = ab.normalized() #Normalize the line
	#Project vector "diff" onto line by using the dot product
	ab *= ap.dot(ab)
	
	var normalPoint = a+ab
	return normalPoint


func follow(p_start : Vector2, p_end : Vector2, p_radius : float):

	#Predict position 50 (arbitrary choice) frames ahead
	var predict = velocity
	predict = predict.normalized();
	predict *= 50;
	var predictLoc = position + predict

	#Look at the line segment
	var a = p_start;
	var b = p_end;

	#Get the normal point to that line
	var normalPoint = getNormalPoint(predictLoc, a, b);
	#print("normalPoint", normalPoint)
	
	#Find target point a little further ahead of normal
	var dir = b-a
	dir = dir.normalized();
	dir *= 10 # This could be based on velocity instead of just an arbitrary 10 pixels
	var target = normalPoint + dir
	#print("target", target)
	#How far away are we from the path?
	var distance = predictLoc.distance_to(normalPoint)
	#Only if the distance is greater than the path's radius do we bother to steer
	if distance > p_radius:
		seek(target)
	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			$AIMenu.visible = !$AIMenu.visible

onready var expPath = "res://Explosion.tscn"

func spawn_explosion():
	var object = load(expPath)
	var mo = object.instance()
	get_parent().add_child(mo)
	mo.global_position = global_position
	mo.scale = Vector2(0.5,0.5)
	
func kill():
	ai_type = aitype_enum.NONE
	velocity = Vector2.ZERO
	spawn_explosion()
	queue_free()
	#$Explosion.visible = true
	#$Sprite.visible = false
	#$Explosion.play_anim("main_explosion")
	


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemies") and body != self:
		body.kill()
		kill()
	if body.is_in_group("player"):
		kill()
		if !body.dead:
			body.kill()
	if body.is_in_group("platform"):
		if has_to_die_in_platform:
			kill()
