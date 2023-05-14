class_name block extends Node2D


var gravity = 2
var gravity_time = 60/gravity
var count = 0
var playing: bool = true
var y_shift = 8
var x_leftBound = -24
var x_rightBound = 24
var floorBound: int = 140
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
		shift_y(y_shift)
		
	
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
		playing = !onFloor()
		
		
func getCells():
	cells = []
	for block in self.get_children():
		cells.append(block.position)
	#print(cells)

func onFloor():
	for block in children:
		if block.position.y == floorBound:
			return true
	return false
	
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
	shift_x(-8)
			
func move_right():
	shift_x(8)
	
func soft_drop():
	gravity_time = 15/gravity

func normal_drop():
	gravity_time = 60/gravity
	
func hard_drop():
	shift_y(floorBound - getLowest())
	
				
func isDone():
	return !playing

func shift_y(shift):
	for block in self.get_children():	
			block.position.y += shift
func shift_x(shift):
	for block in self.get_children():	
			block.position.x += shift

func checkPositions():
	var position = []
	for block in self.get_children():	
		position.append([getX(block),getY(block)])
	return position

func getX(block):
	return (block.position.x-4)/8
	
func getY(block):
	return (block.position.y-4)/8
	
func getLowest():
	var lowestBlock = -9999
	for block in self.get_children():			
		if block.position.y >= lowestBlock:
			lowestBlock = block.position.y
	return lowestBlock

	
	
		
	
		
