extends Control


var paused = false
var restart = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_exit_pressed():
	get_tree().quit()


func _on_restart_pressed():
	get_tree().paused = false
	restart = true


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://start.tscn")
	
		
