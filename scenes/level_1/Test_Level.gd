extends Node2D

@onready var alch1 = $Basic_Alchemist
@onready var alch2 = $Alch2
@onready var alch3 = $Alch3
@onready var timer = $throw_timer
@onready var potion: PackedScene = preload("res://scenes/Alchemist/Potion_Projectile.tscn")



var throwingTime = true
# Called when the node enters the scene tree for the first time.
func _ready():
	alch1.walkTime = 2
	alch1.turnTime = 3
	alch1.turned = true
	alch1.walk = true
	alch1.setup()
	
	alch2.walkTime = 3
	alch2.turnTime = 1
	alch2.turned = true
	alch2.walk = true
	alch2.setup()
	
	alch3.walkTime = 0.1
	alch3.turnTime = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(GameManager.throw_potion == true):
		if throwingTime:
			throwingTime = false
			timer.start()
			var pot = potion.instantiate()
			pot.position = GameManager.AlchMarker
			add_child(pot)
			GameManager.throw_potion = false
		


func _on_throw_timer_timeout():
	GameManager.throw_potion = false
	throwingTime = true
