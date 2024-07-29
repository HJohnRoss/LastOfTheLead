extends Node2D

@onready var alch1 = $Basic_Alchemist

# Called when the node enters the scene tree for the first time.
func _ready():
	alch1.walkTime = 2
	alch1.turnTime = 0.1
	alch1.turned = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
