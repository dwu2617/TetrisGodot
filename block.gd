class_name block extends CharacterBody2D


var gravity = 2
var gravity_time = 60/gravity
var count = 0
var playing: bool = true
var y_shift = 8
var y_increment = 1
var x_leftBound = -24
var x_rightBound = 24
var leftBoundReached = false
var rightBoundReached = false
var collision
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += 1
	if count%gravity_time == 0 && playing:
		collision = move_and_collide(Vector2(0,y_shift*y_increment))
		if collision:
			if collision.get_collider().name != "LeftBoundary" or collision.get_collider().name != "RightBoundary":
				playing = false
		
	if playing:
		if Input.is_action_just_pressed("Counterclockwise"):
			rotate(PI/2)
		if Input.is_action_just_pressed("Left"):
			move_left()
		if Input.is_action_just_pressed("Right"):
			move_right()
		if Input.is_action_pressed("Softdrop"):
			soft_drop()
		if Input.is_action_just_released("Softdrop"):
			normal_drop()
		if Input.is_action_just_pressed("Harddrop"):
			hard_drop()
		if Input.is_action_just_released("Harddrop"):
			normal_drop()
			y_increment = 1
		

func rotate_block(radians):
	self.rotation_degrees = radians

func move_left():
	if !leftBoundReached:
		self.position.x -= 8
			
func move_right():
	if !rightBoundReached:
		self.position.x += 8
	
func soft_drop():
	gravity_time = 15/gravity

func normal_drop():
	gravity_time = 60/gravity
	
func hard_drop():
	gravity_time = 2/gravity
	y_increment *= 5
				
func isDone():
	return !playing

	
	
		
	
		
