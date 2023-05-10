extends Node2D

var current_block
var next_block
var starting_block = true
var blockPos

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
	pass # Replace with function body.

func shuffle_blocks():
	block_array.shuffle()

func current(i):
	return block_array[i]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var block_index = count % 7
	
	if (starting_block || current_block.isDone()==true):
		if current(block_index) == 'i':
			current_block = i_block.instantiate()
			blockPos = Vector2(0,-88)
		elif current(block_index) == 'o':
			current_block = o_block.instantiate()
			blockPos = Vector2(0,-88)
		elif current(block_index) == 't':
			current_block = t_block.instantiate()
			blockPos = Vector2(-4,-84)
		elif current(block_index) == 's':
			current_block = s_block.instantiate()
			blockPos = Vector2(-4,-84)
		elif current(block_index) == 'z':
			current_block = z_block.instantiate()
			blockPos = Vector2(-4,-84)
		elif current(block_index) == 'l':
			current_block = l_block.instantiate()
			blockPos = Vector2(-4,-84)
		elif current(block_index) == 'j':
			current_block = j_block.instantiate()
			blockPos = Vector2(-4,-84)
		get_tree().get_root().add_child(current_block)
		count+=1
		current_block.position = blockPos
				
	if (starting_block):
		starting_block = false
	
