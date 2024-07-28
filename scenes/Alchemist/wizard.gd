extends CharacterBody2D

class_name Wizard

@onready var potion = preload("res://scenes/Alchemist/Potion_Projectile.tscn")

@export var health = 1;
@onready var sprite = $Basic_Alchemist_Sprite
@onready var collision = $CollisionShape2D
@onready var PointLight = $PointLight2D
@onready var timer = $Timer
var thrown = false

func incoming_damage(damage) -> void:
	health -= damage
		
func _process(_delta):
		if PointLight.player:
			throw_potion()

func turn_around():
	if sprite.flip_h:
		sprite.flip_h = false
		collision.position.x *= -1
		PointLight.position.x *= -1
		PointLight.position.y += 3
		PointLight.rotation_degrees = -180
	else:
		sprite.flip_h = true
		collision.position.x *= -1
		PointLight.position.x *= -1
		PointLight.position.y -= 3
		PointLight.rotation_degrees = 0

func throw_potion():
	if !thrown:
		var potion_instance = potion.instantiate()
		add_child(potion_instance)
		thrown = true

func _on_timer_timeout():
	turn_around()
	
