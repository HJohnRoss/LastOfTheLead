extends Control

@onready var game = preload("res://scenes/level_1/level_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
#TODO change to cutscene when we have it.
	get_tree().change_scene_to_file("res://scenes/level_1/Test_Level.tscn")


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/level_1/Test_Level.tscn")
