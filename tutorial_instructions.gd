extends Control
var up = false
var shift = false
var a = false
var down = false
var space = false
var c = false
var move = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Up Arrow- \nclockwise"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Counterclockwise") && up == false:
		$Label.text = "Shift- \ncounter-clockwise"
		up = true
	if Input.is_action_just_pressed("Clockwise") && shift == false && up == true:
		$Label.text = "A to \nturn 180"
		shift = true
	if Input.is_action_just_pressed("180") && a == false && shift == true:
		$Label.text = "Down Arrow to \nsoftdrop"
		a = true
	if Input.is_action_just_pressed("Softdrop") && down == false && a == true:
		$Label.text = "Space to \nharddrop"
		down = true
	if Input.is_action_just_pressed("Harddrop") && space == false && down == true:
		$Label.text = "C to \nhold piece"
		space = true
	if Input.is_action_just_pressed("Hold") && c == false && space == true:
		$Label.text = "Move using right and left arrows"
		c = true
	if Input.is_action_just_pressed("Left") && move == false && c == true:
		$Label.text = "Tutorial Finished!\nSettings-> Menu"
		move = true
