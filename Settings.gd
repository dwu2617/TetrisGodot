extends Control

var sliderValues = [0,0,0]
var sdf = 100
var arr = 10
var das = 60
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sliderValues = [sdf, arr, das]

func _on_sdf_slider_value_changed(value):
	sdf = value

func _on_arr_slider_value_changed(value):
	arr = value

func _on_das_slider_value_changed(value):
	das = value


