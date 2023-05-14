class_name block extends Node2D


var gravity = 5
var gravity_time = 60/gravity
var count = 0
var playing: bool = true
var x_leftBound = -24
var x_rightBound = 24
var floorBound = 17
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
		shift_y(1)
		
	
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

		playing = !onFloor()
	print(getLowest())
		
func getCells():
	cells = []
	for block in self.get_children():
		cells.append(block.position)
	#print(cells)

func onFloor():
	for block in children:
		if getY(block) == floorBound:
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
	if getLeft() > 0:
		shift_x(-1)
			
func move_right():
	if getRight() < 9:
		shift_x(1)
	
func soft_drop():
	gravity_time = 15/gravity

func normal_drop():
	gravity_time = 60/gravity
	
func hard_drop():	
	gravity_time = 1
				
func isDone():
	return !playing

func shift_y(shift):
	for block in self.get_children():	
		block.position.y += shift * 8
func shift_x(shift):
	for block in self.get_children():	
		block.position.x += shift * 8

func checkPositions():
	var pos = []
	for block in self.get_children():	
		pos.append([getX(block),getY(block)])
	return pos

func getX(block):
	return (block.position.x-4)/8
	
func getY(block):
	return (block.position.y-4)/8
	
func getLowest():
	var lowestBlock = -10
	for block in self.get_children():			
		if getY(block) > lowestBlock:
			lowestBlock = getY(block)
	return lowestBlock 
	
func getLeft():
	var leftBlock = 9999
	for block in self.get_children():			
		if getX(block) <= leftBlock:
			leftBlock = getX(block)
	return leftBlock
	
func getRight():
	var rightBlock = -9999
	for block in self.get_children():			
		if getX(block) >= rightBlock:
			rightBlock = getX(block)
	return rightBlock

	
	
		
	
		
