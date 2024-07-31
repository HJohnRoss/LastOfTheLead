extends Node2D

@onready var background = $TextureRect



var text_box_position = Vector2(850, 300)
var arr: Array[String] = ["The philosophers stone is found"
, "Alchemists can now turn lead into gold",
"But their greed has gone too far",
"You seem to be the last piece of lead left",
"You must destroy the stone"]


func _ready():
	DialogueManager.start_dialog(text_box_position, arr)
	
func _input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene_to_file("res://scenes/level_1/Test_Level.tscn")
