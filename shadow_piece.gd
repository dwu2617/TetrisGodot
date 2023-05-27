extends Sprite2D
var children = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for block in self.get_children():
		children.append(block)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func block(i):
	return children[i]
