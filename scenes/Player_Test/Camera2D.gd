extends Camera2D



var arr: Array[String] = ["You did it!", 
"You can finally rest easy", 
"knowing future generation's of lead", 
"won't be turned to gold."]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func end_text():
	DialogueManager.start_dialog(global_position + Vector2(0, -300), arr)
	print(arr)
