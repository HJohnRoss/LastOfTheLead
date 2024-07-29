extends CharacterBody2D



func _ready():
	pass

func _physics_process(delta):
	rotation_degrees += 300 * delta
	position = position.move_toward(GameManager.DEATH_MARKER.global_position - GameManager.AlchMarker, 500 * delta)




func _on_area_2d_body_entered(body):
	if body.name == "Player":
		GameManager.PLAYER_HEALTH = 0
		queue_free()
