extends Control

@onready var global = get_node("/root/Global") 
var sliderValues = [0,0,0]
var paused = false
var resume
var restart = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sliderValues = [global.sdf, global.arr, global.das]
	if Input.is_action_just_pressed("My Controls"):
		global.sdf = 100
		global.arr = 100
		global.das = 50

func _on_sdf_slider_value_changed(value):
	global.sdf = value

func _on_arr_slider_value_changed(value):
	global.arr = value

func _on_das_slider_value_changed(value):
	global.das = value


func _on_resume_pressed():
	paused = false
	resume = true
	get_tree().paused = false
	

func _on_my_controls_pressed():
	global.sdf = 100
	global.arr = 100
	global.das = 50

func _on_exit_pressed():
	get_tree().quit()


func _on_restart_pressed():
	get_tree().paused = false
	restart = true

func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://start.tscn")
	
		
