extends CharacterBody2D


func _ready():
	pass
	
func _physics_process(delta):
	rotation_degrees += 300 * delta
	position = position.move_toward(GameManager.MARKER_HEAD.global_position, 500 * delta)


