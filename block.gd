class_name block extends Node2D


var gravity = 2
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
var default = 10
var arr = 3
var das = 5
var dasLeftCount = 0
var dasRightCount = 0
var sdf = 10


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
	
	actions(count)
		
func actions(count):
	if playing:		
		if Input.is_action_just_pressed("Counterclockwise"):
			rotate_block(PI/2)
			checkRotation(PI/2)
		if Input.is_action_just_pressed("Clockwise"):
			rotate_block(-PI/2)	
			checkRotation(PI/2)
			
		if Input.is_action_pressed("Left"):
			dasLeftCount +=1
			dasRightCount = 0
			if dasLeftCount%int(das) == 0:
				if count%int(arr) == 0:
					move_left()
			else: 
				if count%default == 0:
					move_left()
		if Input.is_action_pressed("Right"):
			dasRightCount +=1
			dasLeftCount = 0
			if dasRightCount%int(das) == 0:
				if count%int(arr) == 0:
					move_right()
			else: 
				if count%default == 0:
					move_right()
		if Input.is_action_pressed("Softdrop"):
			soft_drop()
		if Input.is_action_just_released("Softdrop"):
			normal_drop()
		if Input.is_action_just_pressed("Harddrop"):
			hard_drop()
		playing = !onFloor()
		#print(sdf)
		
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
		
func checkRotation(radians):
	pivotPoint = cells[3]
	var rotationDisplacement = 0
	var cosTheta = cos(radians)
	var sinTheta = sin(radians)
	var furthestPoint = 4

	for i in range(cells.size()):		
		var cellPosition = cells[i]
		var translatedPoint = cellPosition - pivotPoint
		var rotatedX = translatedPoint.x * cosTheta - translatedPoint.y * sinTheta
		var rotatedY = translatedPoint.x * sinTheta + translatedPoint.y * cosTheta
		if (Vector2(rotatedX,rotatedY) + pivotPoint).x<1:
			if (Vector2(rotatedX,rotatedY) + pivotPoint).x < furthestPoint:
				furthestPoint = (Vector2(rotatedX,rotatedY) + pivotPoint).x

		if (Vector2(rotatedX,rotatedY) + pivotPoint).x>9*8+4:
			if (Vector2(rotatedX,rotatedY) + pivotPoint).x > furthestPoint:
				furthestPoint = (Vector2(rotatedX,rotatedY) + pivotPoint).x - 8*8 
	rotationDisplacement = -(furthestPoint-4)/8
	shift_x(rotationDisplacement)

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
	gravity_time = int(sdf/gravity)

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

	
	
		
	
		
