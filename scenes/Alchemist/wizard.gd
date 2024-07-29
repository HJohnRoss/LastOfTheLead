extends CharacterBody2D

class_name Wizard

@onready var potion: PackedScene = preload("res://scenes/Alchemist/Potion_Projectile.tscn")

@export var health = 1;
@onready var sprite = $Basic_Alchemist_Sprite
@onready var collision = $CollisionShape2D
@onready var PointLight = $PointLight2D
@onready var turnAroundTimer = $TurnAroundTimer
@onready var throwTime = $ThrowTimer
@onready var walkTimer = $WalkTimer
@onready var positionMarker = $Marker2D

var displacement = position.x

var walk = false
var thrown = false
var direction = 1

#CONTROL VARIABLES
var walkTime = 1
var turnTime = 2
var turned = true



func incoming_damage(damage) -> void:
	health -= damage
		
func _process(delta):
		walkTimer.set("wait_time", walkTime)
		turnAroundTimer.set("wait_time", turnTime + walkTime)
		if thrown:
			GameManager.AlchMarker = Vector2(position.x + displacement, position.y)
		if turned:
			turn_around()
			turned = false
		if PointLight.player:
			throw_potion()
			print(get("position"))
			print(displacement)
		if walk:
			position.x += 100 * delta * direction
			if thrown:
				displacement += 100 * delta * direction

func turn_around():
	if sprite.flip_h:
		sprite.flip_h = false
		collision.position.x *= -1
		PointLight.position.x *= -1
		PointLight.position.y += 3
		PointLight.rotation_degrees = -180
		direction = -1
		walk = true
		walkTimer.start()
		turnAroundTimer.start()
	else:
		sprite.flip_h = true
		collision.position.x *= -1
		PointLight.position.x *= -1
		PointLight.position.y -= 3
		PointLight.rotation_degrees = 0
		direction = 1
		walk = true
		walkTimer.start()
		turnAroundTimer.start()

func throw_potion():
	if !thrown:
		var potion_instance = potion.instantiate()
		add_child(potion_instance)
		thrown = true
		throwTime.start()
		


	

func _on_turn_around_timer_timeout():
	turn_around()

func _on_walk_timer_timeout():
	walk = false
	displacement = 0



func _on_throw_timer_timeout():
	thrown = false
	
	
func setup():
	walkTimer.set("wait_time", walkTime)
	turnAroundTimer.set("wait_time", turnTime + walkTime)
	walkTimer.start()
	turnAroundTimer.start()
	if turned:
		turn_around()
		turned = false


