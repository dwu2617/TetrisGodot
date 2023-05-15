class_name l_block extends block




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func actions(count):
	if playing:
		if Input.is_action_just_pressed("Counterclockwise"):
			rotate_block(PI/2)
			checkRotation(PI/2)
		if Input.is_action_just_pressed("Clockwise"):
			rotate_block(-PI/2)	
			checkRotation(PI/2)
		if Input.is_action_just_pressed("180"):
			rotate_block(PI)
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


