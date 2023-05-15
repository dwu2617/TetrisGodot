class_name t_block extends block




# Called when the node enters the scene tree for the first time.
func _ready():
	pass


	
func actions():
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
# Called every frame. 'delta' is the elapsed time since the previous frame.

