class_name o_block extends block




# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func rotate_block(radians):
	pivotPoint = (cells[0] + cells[1] + cells[2] + cells[3])/4
	var cosTheta = cos(radians)
	var sinTheta = sin(radians)

	for i in range(cells.size()):
		
		var cellPosition = cells[i]
		var translatedPoint = cellPosition - pivotPoint
		var rotatedX = translatedPoint.x * cosTheta - translatedPoint.y * sinTheta
		var rotatedY = translatedPoint.x * sinTheta + translatedPoint.y * cosTheta
		children[i].position = Vector2(rotatedX,rotatedY) + pivotPoint
	
# Called every frame. 'delta' is the elapsed time since the previous frame.

