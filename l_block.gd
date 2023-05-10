class_name l_block extends block




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

	
func _on_area_2d_body_entered(body):
	if body.name == "LeftBoundary":
		leftBoundReached = true
	elif body.name == "RightBoundary":
		rightBoundReached = true


func _on_area_2d_body_exited(body):
	if body.name == "LeftBoundary":
		leftBoundReached = false
	elif body.name == "RightBoundary":
		rightBoundReached = false

	
