extends Node2D

@onready var global = get_node("/root/Global") 
var current_block
var wait_block
var startPos
var blockPos
var map = []
var map_height = 100
var map_width = 10
var sdf
var arr
var das
var allTetrominoes = []
var bottom = []
var playing = true
var tetrominoCount = 0
var hold
var firstHold
var holdPiece
var score = 0
var linesCleared
var canHold = true
var placeholder
var line_clear = preload("res://Sound Effects/tetris-gb-21-line-clear.mp3")
var tetris_clear = preload("res://Sound Effects/tetris-gb-22-tetris-4-lines.mp3")
var death = preload("res://Sound Effects/tetris-gb-25-game-over.mp3")
var theme 
var previousX
var numLines = 0
var pps = 0
var scoreMultiplier = 1
var lastElapsed = 0

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
var time = 60
var elapsed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	initializeMap() # Replace with function body.
	shuffle_blocks()
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
			wait_block.position = Vector2(120,count*30+670)
		allTetrominoes.append(wait_block)
		count+=1
		tetrominoCount+=1
		block_index = count%7
	current_block = allTetrominoes[0]
	current_block.shift_x(5)
	current_block.shift_y(82)
	current_block.position = Vector2(0,0)
	get_tree().get_root().add_child.call_deferred(current_block)
	current_block.active=true
	previousX = current_block.getLeft()
	

func shuffle_blocks():
	block_array.shuffle()

func current(i):
	return block_array[i]

func initializeMap():
	for i in range(map_height+1):
		map.append(["--", "--","--","--","--","--","--","--","--","--", "", "", ""])

		
func updateMap():
	for a in range(4):		
		map[blockPos[a][1]][blockPos[a][0]] = "[]"	
	print(tetrominoCount)
	print(allTetrominoes[0])
	printMap()


func printMap():
	var row = ""
	for i in range(map_height-82):
		for j in range(map_width):
			row += (map[82+i][j])
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
	if current_block.getLowest() == 99:
		return true
	return false
			
func getSliderValues():
	sdf = $Settings.sliderValues[0]		
	arr = $Settings.sliderValues[1]		
	das = $Settings.sliderValues[2]		
	
func setSettingValues():
	current_block.sdf = (100-sdf)/5+2
	current_block.arr = arr/10
	current_block.das = das/8+1

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
	linesCleared = 0
	if checkLines()!=[]:
		for i in checkLines():
			for tetromino in allTetrominoes:
					for blocks in tetromino.get_children():
						if tetromino.getY(blocks) == i:
							map[tetromino.getY(blocks)][tetromino.getX(blocks)] = "--"
							tetromino.clear(blocks)									
							score += scoreMultiplier * 20 * linesCleared
						elif tetromino.getY(blocks) < i:
							if tetromino.active == true:
								tetromino.move(blocks)
			linesCleared += 1
			numLines +=1		
			shiftDown(map_height-i)
		if linesCleared < 4:
			$Effects.stream = line_clear
			$Effects.play()
		else:
			$Effects.stream = tetris_clear
			$Effects.play()
				
func shiftDown(stationary):
	for i in range(map_height-stationary):
		if map_height-i-stationary -1== 0:
			map[map_height-i-stationary-1] = ["--", "--","--","--","--","--","--","--","--","--", "", "", ""]
		else: map[map_height-i-stationary] = map[map_height-i-stationary-1]				
		
func checkTop():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.

func getBottom():
	bottom = []
	var bottomReached
	for i in range(map_width):
		bottomReached = false
		for j in range(map_height):
			if map[j][i] == "[]" and bottomReached == false:
				bottom.append(j)
				bottomReached = true
		if bottomReached == false:
			bottom.append(map_height)
	return bottom
	
func moveShadow():
	var column 
	var row
	var y_shift = getShadowShift()
	var i = -1
	for block in current_block.get_children():
		i+=1
		column = current_block.getX(block)
		row = current_block.getY(block)
		$ShadowPiece.block(i).position = Vector2(column*8+4,(row+y_shift-(map_height-17))*8+4)


func getShadowShift():
	var column
	var i = -1
	var y_shift = 1000
	for block in current_block.get_children():
		i+=1
		column = current_block.getX(block)
		if column < 10:
			if bottom[column] - current_block.getY(block) < y_shift:
				y_shift = bottom[column] - current_block.getY(block)
				#print(y_shift)
	if y_shift < 0:
		return 1
	return y_shift
	
func dead():
	for i in range(map_width):
		for j in range(map_height):
			if map[j][i] == "[]" && j == 82:
				return true
	return false
func _process(delta): 
	if elapsed !=0:
		pps = (tetrominoCount-4)/elapsed
	if Input.is_action_just_pressed("Restart"):
		restart()
	
	else:
		elapsed += delta
	if time-elapsed <= 0:
		elapsed = time
	$Stats.text=str("score ", score, "\n", "time ", "%0.3f" % (time-elapsed), "\n", "pps ", "%0.2f" % pps )
	$ScoreCount.text=str(score)
	if elapsed >= time:
		deathScreen()
	if dead():
		$Effects.stream = death
		$Effects.play()
		deathScreen()
	$Background.volume_db = $MusicSettings.music
	$Effects.volume_db = $MusicSettings.soundEffects
	$PieceEffects.volume_db = $MusicSettings.soundEffects + 5
	if theme != $MusicSettings.song:
		theme = $MusicSettings.song
		$Background.stream = theme
		$Background.play()
	if !$Background.is_playing():
		$Background.stream = theme
		$Background.play()

	if playing:
		if current_block.pieceEffect != null:
			$PieceEffects.stream = current_block.pieceEffect
			$PieceEffects.play()
	
	
		block_index = count % 7

		if Input.is_action_just_pressed("Hold"):
			if hold:
				if (allTetrominoes.find(current_block) > hold-1):
					current_block.active = false
					current_block.position = Vector2(-50-blockPos[0][0]*8,700-blockPos[0][1]*8)
					print("yay")
					current_block = allTetrominoes[hold-1]
					current_block.reset()
					print(current_block.initialPos)
					current_block.position = Vector2(0,0)
					current_block.active = true


			else: 
				current_block.active = false
				current_block.position = Vector2(-50-blockPos[0][0]*8,700-blockPos[0][1]*8)
				firstHold = true
			
			hold = tetrominoCount - 3	
			
		if block_index == 0: 
			shuffle_blocks()
			
		if (current_block.isDone()==true or firstHold):
			if firstHold:
				firstHold = false
			else:
				score += current_block.getLowest()
				updateMap()
			blockPos = current_block.checkPositions()
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
							

			allTetrominoes[tetrominoCount-1].position = (Vector2(120,730))
			allTetrominoes[tetrominoCount-2].position = (Vector2(120,700))
			current_block = allTetrominoes[tetrominoCount-3]
			current_block.shift_x(5)
			current_block.shift_y(82)
			current_block.position = (Vector2(0,0))
			current_block.active = true
			get_tree().get_root().add_child(wait_block)
			allTetrominoes.append(wait_block)		
				
			wait_block.position = (Vector2(120,760))
			count+=1					
			
			tetrominoCount+=1
			checkRows()
		
		
		blockPos = current_block.checkPositions()
		getSliderValues()	
		setSettingValues()
			
		if (onBlock()):
			current_block.playing = false
		if !onBlock() and current_block.hardDrop== false and previousX !=current_block.getLeft():
			current_block.playing = true
			current_block.doneCounter = 100
			previousX = current_block.getLeft()

		current_block.setBoundaries(map, bottom)
		
		$Score.text = "Score\n" + str(score)
		
		getBottom()
		moveShadow()
		if $Settings.resume:
			resume($Settings)
		if $Settings.restart:
			restart()
		if $DeathScreen.restart:
			restart()
		if $MusicSettings.resume:
			resume($MusicSettings)
		if elapsed > 50:
			current_block.gravity_time = 1
			scoreMultiplier = 20
		elif elapsed > 40:
			current_block.gravity_time = 2
			scoreMultiplier = 10
		elif elapsed > 30:
			current_block.gravity_time = 5
			scoreMultiplier = 5
		elif elapsed > 20:
			current_block.gravity_time = 10
			scoreMultiplier = 3
		elif elapsed > 10:
			current_block.gravity_time = 20


		
func openScreen(screen):
	screen.paused = true
	$Background.volume_db = -20
	$ShadowPiece.visible = false
	for block in allTetrominoes:
		block.visible = false
	get_tree().paused = true
	$SettingsBackground.visible = true
	screen.visible = true
	for i in range(9):
		$SettingsBackground.modulate.a+=0.05
		screen.modulate.a+=0.2
		await get_tree().create_timer(0.005).timeout	
		
func _on_settings_button_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		openScreen($Settings)

func _on_music_button_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		openScreen($MusicSettings)

func deathScreen():
	if score > global.highscore_blitz:
		$Win.text = "Highscore!\n %d" % score
		global.highscore_blitz = score
	else:
		$Win.text = "%d" % score
	openScreen($DeathScreen)
	
		
func resume(setting):
	setting.resume = false
	$Background.volume_db = 0
	for block in allTetrominoes:
		block.visible = true
	for i in range(9):
		$SettingsBackground.modulate.a-=0.05
		setting.modulate.a-=0.2
		await get_tree().create_timer(0.005).timeout
	$SettingsBackground.visible = false
	setting.visible = false
	$ShadowPiece.visible = true

	
	
func restart():
	get_tree().paused = false
	$Settings.restart = false
	get_tree().reload_current_scene()
		


