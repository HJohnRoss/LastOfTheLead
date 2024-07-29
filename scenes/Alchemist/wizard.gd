extends CharacterBody2D

class_name Wizard

@onready var potion: PackedScene = preload("res://scenes/Alchemist/Potion_Projectile.tscn")

@export var health = 1;
@onready var sprite = $Basic_Alchemist_Sprite
@onready var collision = $CollisionShape2D
@onready var PointLight = $PointLight2D
@onready var turnAroundTimer = $TurnAroundTimer
@onready var walkTimer = $WalkTimer

var walk = true
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
		turnAroundTimer.set("wait_time", turnTime)
		if turned:
			turn_around()
			turned = false
		GameManager.AlchMarker = get("position")
		if PointLight.player:
			throw_potion()
		if walk:
			position.x += 100 * delta * direction

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
	else:
		sprite.flip_h = true
		collision.position.x *= -1
		PointLight.position.x *= -1
		PointLight.position.y -= 3
		PointLight.rotation_degrees = 0
		direction = 1
		walk = true
		walkTimer.start()

func throw_potion():
	if !thrown:
		var potion_instance = potion.instantiate()
		add_child(potion_instance)
		thrown = true

func _on_timer_timeout():
	turn_around()
	pass
	


func _on_walk_timer_timeout():
	walk = false
	turnAroundTimer.start()
