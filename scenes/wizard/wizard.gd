extends CharacterBody2D

class_name Wizard

@export var health = 1;


func incoming_damage(damage) -> void:
	health -= damage
	if health == 0:
		queue_free()
