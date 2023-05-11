class_name block extends Node2D


var gravity = 2
var gravity_time = 60/gravity
var count = 0
var playing: bool = true
var y_shift = 8
var y_increment = 1
var x_leftBound = -24
var x_rightBound = 24
var collision
var cells = []
var children = []
var pivotPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if count == 0:
		for block in self.get_children():
			children.append(block)
	count += 1
	getCells()
	if count%gravity_time == 0 && playing:
		for block in self.get_children():	
			block.position.y += y_shift*y_increment		
	
	if playing:
		if Input.is_action_just_pressed("Counterclockwise"):
			rotate_block(PI/2)
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
		
func getCells():
	cells = []
	for block in self.get_children():
		cells.append(block.position)
	#print(cells)
	
func getChildren():
	for block in self.get_children():
		children.append(block)
		
		
func rotate_block(radians):
	pivotPoint = cells[3]
	var cosTheta = cos(radians)
	var sinTheta = sin(radians)

	for i in range(cells.size()):
		
		var cellPosition = cells[i]
		var translatedPoint = cellPosition - pivotPoint
		var rotatedX = translatedPoint.x * cosTheta - translatedPoint.y * sinTheta
		var rotatedY = translatedPoint.x * sinTheta + translatedPoint.y * cosTheta
		children[i].position = Vector2(rotatedX,rotatedY) + pivotPoint
	

func move_left():
	self.position.x -= 8
			
func move_right():
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
	


	
	
		
	
		
