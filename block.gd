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
var rightBounded = false
var leftBounded = false
var done = false
var doneCounter = 200
var hardDrop = false
var map

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
	if !playing:
		if !hardDrop:
			doneCounter-=1
			if doneCounter == 0:
				done = true
		else:
			done = true
	actions(count)
		
func actions(count):
	if !done:		
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
		elif map[change((Vector2(rotatedX,rotatedY) + pivotPoint).y)][change((Vector2(rotatedX,rotatedY) + pivotPoint).x)] == "[]":
			shift_y(-2)
		elif change((Vector2(rotatedX,rotatedY) + pivotPoint).y)>17:
			shift_y(-1)
		if change((Vector2(rotatedX,rotatedY) + pivotPoint).x)>9:
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
	if getLeft() > 0 and leftBounded == false:
		shift_x(-1)
			
func move_right():
	if getRight() < 9 and rightBounded == false:
		shift_x(1)
	
func soft_drop():
	gravity_time = int(sdf/gravity)

func normal_drop():
	gravity_time = 60/gravity
	
func hard_drop():	
	hardDrop = true
	gravity_time = 1
	
				
func isDone():
	return done

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
	var left = 9999
	for block in self.get_children():			
		if getX(block) <= left:
			left = getX(block)
	return left
	
func getRight():
	var right = -9999
	for block in self.get_children():			
		if getX(block) >= right:
			right = getX(block)
	return right

	
func setBoundaries(mapArray):
	rightBounded = false
	leftBounded = false
	for block in self.get_children():	
		if mapArray[getY(block)][getX(block)-1] == "[]":
			leftBounded = true
		if mapArray[getY(block)][getX(block)+1] == "[]":
			rightBounded = true
	map = mapArray

func change(value):
	return(value-4)/8
		
	
		
	
		
