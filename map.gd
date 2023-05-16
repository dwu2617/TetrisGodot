extends Node2D

var current_block
var wait_block
var startPos
var blockPos
var map = []
var map_height = 18
var map_width = 10
var sdf
var arr
var das
var allTetrominoes = []
var playing = true
var tetrominoCount = 0
var hold

var block_array = ['i','o','t','s','z','l','j']
var i_block = load("res://i_block.tscn")
var o_block = load("res://o_block.tscn")
var t_block = load("res://t_block.tscn")
var s_block = load("res://s_block.tscn")
var z_block = load("res://z_block.tscn")
var l_block = load("res://l_block.tscn")
var j_block = load("res://j_block.tscn")
var count = 0
var block_index = count%7
# Called when the node enters the scene tree for the first time.
func _ready():
	initializeMap() # Replace with function body.
	
	for i in range(4):
		if current(block_index) == 'i':
			wait_block = i_block.instantiate()
					
		elif current(block_index) == 'o':
			wait_block = o_block.instantiate()
			
		elif current(block_index) == 't':
			wait_block = t_block.instantiate()

		elif current(block_index) == 's':
			wait_block = s_block.instantiate()

		elif current(block_index) == 'z':
			wait_block = z_block.instantiate()

		elif current(block_index) == 'l':
			wait_block = l_block.instantiate()

		elif current(block_index) == 'j':
			wait_block = j_block.instantiate()
					
		if i!=0:
			get_tree().get_root().add_child.call_deferred(wait_block)
			wait_block.position = Vector2(120,count*50-30)
		allTetrominoes.append(wait_block)
		count+=1
		tetrominoCount+=1
		block_index = count%7
	current_block = allTetrominoes[0]
	current_block.position = Vector2(0,0)
	current_block.shift_x(5)
	get_tree().get_root().add_child.call_deferred(current_block)
	current_block.active=true
	
	

func shuffle_blocks():
	block_array.shuffle()

func current(i):
	return block_array[i]

func initializeMap():
	for i in range(map_height+1):
		map.append(["--", "--","--","--","--","--","--","--","--","--", "", "", ""])

		
func updateMap():
	for i in range(4):		
		map[blockPos[i][1]][blockPos[i][0]] = "[]"	
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
	print()
				
func initiateBlock():
	startPos = Vector2(0,0)
	current_block.shift_x(5)		

func onBlock():
	for i in range(4):
		if map[blockPos[i][1]+1][blockPos[i][0]] == "[]":
			return true
	return false
			
func getSliderValues():
	sdf = $Settings.sliderValues[0]		
	arr = $Settings.sliderValues[1]		
	das = $Settings.sliderValues[2]		
	
func setSettingValues():
	current_block.sdf = (100-sdf)/5+5
	current_block.arr = arr/20+1
	current_block.das = das/20+1

func checkLines():
	var blockCount = 0;
	var fullRows = []
	for i in range(map_height):
		for j in range(map_width):
			if map[i][j] == "[]":
				blockCount +=1 
		if blockCount == 10:
			fullRows.append(i)
			blockCount = 0
		else:
			blockCount = 0

	return fullRows

func checkRows():
	if checkLines()!=[]:
		for i in checkLines():
			for tetromino in allTetrominoes:
				for blocks in tetromino.get_children():
					if tetromino.getY(blocks) == i:
						map[tetromino.getY(blocks)][tetromino.getX(blocks)] = "--"
						blocks.queue_free()				
					elif tetromino.getY(blocks) < i:
						blocks.position.y +=8
			shiftDown(map_height-i)
				
func shiftDown(stationary):
	for i in range(map_height-stationary):
		if map_height-i-stationary -1== 0:
			map[map_height-i-stationary-1] = ["--", "--","--","--","--","--","--","--","--","--", "", ""]
		else: map[map_height-i-stationary] = map[map_height-i-stationary-1]				
		
func checkTop():
	if blockPos[0][1] < 0:
		playing=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing:
		block_index = count % 7
		if block_index == 0: 
			shuffle_blocks()
		if (current_block.isDone()==true):
			blockPos = current_block.checkPositions()
			updateMap()
			checkTop()
			if current(block_index) == 'i':
				wait_block = i_block.instantiate()
				
			elif current(block_index) == 'o':
				wait_block = o_block.instantiate()
				
			elif current(block_index) == 't':
				wait_block = t_block.instantiate()				

			elif current(block_index) == 's':
				wait_block = s_block.instantiate()

			elif current(block_index) == 'z':
				wait_block = z_block.instantiate()

			elif current(block_index) == 'l':
				wait_block = l_block.instantiate()

			elif current(block_index) == 'j':
				wait_block = j_block.instantiate()
							

			allTetrominoes[tetrominoCount-1].position = (Vector2(120,70))
			allTetrominoes[tetrominoCount-2].position = (Vector2(120,20))
			current_block = allTetrominoes[tetrominoCount-3]
			current_block.shift_x(5)
			current_block.position = (Vector2(0,0))
			current_block.active = true
			get_tree().get_root().add_child(current_block)
			get_tree().get_root().add_child(wait_block)
			allTetrominoes.append(wait_block)
			

				
			wait_block.position = (Vector2(120,120))
			count+=1		
			
			
			tetrominoCount+=1
			checkRows()
				
		blockPos = current_block.checkPositions()
		getSliderValues()	
		setSettingValues()
			
		if (onBlock()):
			current_block.playing = false
		current_block.setBoundaries(map)
			
			
	
	
	

		
	
	
