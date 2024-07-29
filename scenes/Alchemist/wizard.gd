extends CharacterBody2D

class_name Wizard

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var potion: PackedScene = preload("res://scenes/Alchemist/Potion_Projectile.tscn")

@export var health = 1;
@onready var sprite = $Basic_Alchemist_Sprite
@onready var collision = $CollisionShape2D
@onready var PointLight = $PointLight2D
@onready var turnAroundTimer = $TurnAroundTimer
@onready var throwTime = $ThrowTimer
@onready var walkTimer = $WalkTimer
@onready var positionMarker = $Marker2D
@onready var anim = $Basic_Alchemist_Animation

var displacement = 0


var walk = false
var thrown = false
var thrown_anim = false
var dead = false
var direction = 1

#CONTROL VARIABLES
var walkTime = 1
var turnTime = 2
var turned = true



func incoming_damage(damage) -> void:
	health -= damage
		
func _process(delta):
		if dead:
			anim.speed_scale = 4
			anim.play("Death")
			set_physics_process(false)
			set_process(false)
		else:
			walkTimer.set("wait_time", walkTime)
			turnAroundTimer.set("wait_time", turnTime + walkTime)
			if turned:
				turn_around()
				turned = false
			if PointLight.player:
				throw_potion()
				thrown_anim = true

			if walk:
				if !thrown_anim:
					anim.play("Walking")
				else:
					anim.play("Throwing")
				position.x += 100 * delta * direction
				displacement += 100 * delta * direction
			else:
				if !thrown_anim:
					anim.play("Idle")
				else:
					anim.play("Throwing")
				
func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
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
	GameManager.AlchMarker = Vector2(position.x, position.y)
	GameManager.throw_potion = true
		


	

func _on_turn_around_timer_timeout():
	turn_around()

func _on_walk_timer_timeout():
	walk = false
	displacement = 0


	
	
func setup():
	walkTimer.set("wait_time", walkTime)
	turnAroundTimer.set("wait_time", turnTime + walkTime)
	walkTimer.start()
	turnAroundTimer.start()
	if turned:
		turn_around()
		turned = false




func _on_basic_alchemist_animation_animation_finished(anim_name):
	if anim_name == "Throwing":
		thrown_anim = false
	if anim_name == "Death":
		queue_free()


func _on_area_2d_area_entered(area):
	if area.name == "Stomp":
		dead = true
