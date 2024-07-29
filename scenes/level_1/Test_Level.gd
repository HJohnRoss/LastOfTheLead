extends Node2D

@onready var alch1 = $Basic_Alchemist
@onready var alch2 = $Alch2
# Called when the node enters the scene tree for the first time.
func _ready():
	alch1.walkTime = 2
	alch1.turnTime = 5
	alch1.turned = true
	alch1.walk = true
	alch1.setup()
	alch2.walkTime = 3
	alch2.turnTime = 4
	alch2.turned = true
	alch2.walk = true
	alch2.setup()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
