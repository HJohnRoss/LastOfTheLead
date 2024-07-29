extends CharacterBody2D

@onready var explosionParticles = $Explosion
@onready var sprite = $Sprite2D

var moving = true

func _ready():
	pass

func _physics_process(delta):
	if moving:
		rotation_degrees += 300 * delta
		position = position.move_toward(GameManager.DEATH_MARKER.global_position, 500 * delta)




func _on_area_2d_body_entered(body):
	if body.name == "Player":
		GameManager.PLAYER_HEALTH = 0
		moving = false
		sprite.visible = false
		explosionParticles.emitting = true
		



func _on_explosion_finished():
	queue_free()
