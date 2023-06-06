extends Control

@onready var global = get_node("/root/Global") 
var paused = false
var resume
var music = 0
var soundEffects = 0
var song 


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/OptionButton.add_item("Classic")
	$VBoxContainer/OptionButton.add_item("Tetris 99")
	$VBoxContainer/OptionButton.add_item("'Hold on Tight'")
	$VBoxContainer/OptionButton.add_item("'Hold on Tight' instrumental")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	song = global.theme
	


func _on_resume_pressed():
	paused = false
	resume = true
	get_tree().paused = false




func _on_effect_slider_value_changed(value):
	soundEffects = value


func _on_music_slider_value_changed(value):
	music = value


func _on_option_button_item_selected(index):
	var currentlySelected = index
	if currentlySelected == 0:
		global.theme = preload("res://tetrisTheme.mp3")
	if currentlySelected == 1:
		global.theme = preload("res://Tetris 99.mp3")
	if currentlySelected == 2:
		global.theme = preload("res://Hold On Tight.mp3")
	if currentlySelected == 3:
		global.theme = preload("res://Hold On Tight Instrumental.mp3")
		
