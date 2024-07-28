extends CharacterBody2D



func _ready():
	pass

func _physics_process(delta):
	rotation_degrees += 300 * delta
	position = position.move_toward(GameManager.DEATH_MARKER.global_position - GameManager.AlchMarker, 500 * delta)


