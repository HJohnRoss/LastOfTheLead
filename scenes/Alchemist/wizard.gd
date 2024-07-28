extends CharacterBody2D

class_name Wizard

@export var health = 1;
@onready var sprite = $Basic_Alchemist_Sprite
@onready var collision = $CollisionShape2D
@onready var PointLight = $PointLight2D
@onready var timer = $Timer

func incoming_damage(damage) -> void:
	health -= damage
		
func _process(_delta):
		if PointLight.player:
			PointLight.look_at(PointLight.player.global_position)
			timer.paused = true
			

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


func _on_timer_timeout():
	turn_around()
	
