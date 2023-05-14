extends Node2D

var current_block
var next_block
var starting_block = true
var blockPos
var map = []
var map_height = 18
var map_width = 10
var block_stopped = false


var block_array = ['i','o','t','s','z','l','j']
var i_block = load("res://i_block.tscn")
var o_block = load("res://o_block.tscn")
var t_block = load("res://t_block.tscn")
var s_block = load("res://s_block.tscn")
var z_block = load("res://z_block.tscn")
var l_block = load("res://l_block.tscn")
var j_block = load("res://j_block.tscn")
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	initializeMap() # Replace with function body.

func shuffle_blocks():
	block_array.shuffle()

func current(i):
	return block_array[i]

func initializeMap():
	for i in range(map_height):
		map.append(["--", "--","--","--","--","--","--","--","--","--"])
		i+=1

		
func updateMap():
	var blockPos = current_block.checkPositions()
	var i=0
	if current_block.isDone()==true:
		while i < 4:			
			map[blockPos[i][1]][blockPos[i][0]] = "[]"	
			i+=1
		printMap()


func printMap():
	var row = ""
	for i in range(map_height):
		for j in range(map_width):
			row += (map[i][j])
			j+=1
		print(row)
		row = ""
		i+=1
		
			

	
func initiateBlock():
	blockPos = Vector2(0,0)
	current_block.shift_x(40)		

func onBlock():
	var blockPos = current_block.checkPositions()
	for i in range(4):
		if map[blockPos[i][1]+1][blockPos[i][0]] == "[]":
			print("yay")
			return true
	return false
			
func floorBound():
	var highestFloorBound= 140
	var blockPos = current_block.checkPositions()
	for i in range(map_height):
		for j in range(4):
			if map[i][blockPos[j][0]] == "[]" and i < highestFloorBound:
				highestFloorBound = i * 8 - 4
	return highestFloorBound
	
func giveFloorBound():
	current_block.floorBound = floorBound()
				

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var block_index = count % 7
	
	if (starting_block || current_block.isDone()==true):
		if !starting_block:
			updateMap()
		if current(block_index) == 'i':
			current_block = i_block.instantiate()
			
		elif current(block_index) == 'o':
			current_block = o_block.instantiate()
			
		elif current(block_index) == 't':
			current_block = t_block.instantiate()

		elif current(block_index) == 's':
			current_block = s_block.instantiate()

		elif current(block_index) == 'z':
			current_block = z_block.instantiate()

		elif current(block_index) == 'l':
			current_block = l_block.instantiate()

		elif current(block_index) == 'j':
			current_block = j_block.instantiate()
			
		initiateBlock()
		
		get_tree().get_root().add_child(current_block)
		count+=1
		
		current_block.position = blockPos	
	giveFloorBound()
	if (starting_block):
		starting_block = false
	if (onBlock()):
		current_block.playing = false
	
		
		
	
	
