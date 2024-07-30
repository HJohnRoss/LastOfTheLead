extends Control

var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()
		
func pauseMenu():
	paused = !paused
	if paused:
		set_visible(paused)
		Engine.time_scale = 0
	else:
		set_visible(paused)
		Engine.time_scale = 1


func _on_resume_pressed():
	pauseMenu()
	

func _on_quit_pressed():
	get_tree().quit()


func _on_return_to_menu_pressed():
	pauseMenu()
	get_tree().change_scene_to_file("res://scenes/MainMenu/MainMenu.tscn")


func _on_restart_pressed():
	pauseMenu()
	get_tree().change_scene_to_file("res://scenes/level_1/Test_Level.tscn")
