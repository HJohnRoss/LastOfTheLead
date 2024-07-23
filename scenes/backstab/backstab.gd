extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const damage = 1;

func _process(_delta: float) -> void:
	if !animation_player.is_playing():
		collision_shape_2d.set_disabled(true)

func swing(weapon_left: bool) -> void:
	# enabling the collision for the sword and playing the animation
	collision_shape_2d.set_disabled(false)
	if weapon_left:
		animation_player.play("backstab_left")
	else:
		animation_player.play("backstab_right")

func swap_animation_side(side: String) -> void:
	var curr_animation_name = animation_player.current_animation
	if curr_animation_name == "backstab_left" && side == "left":
		return
	elif curr_animation_name == "backstab_right" && side == "right":
		return
	
	var curr_animation_time = animation_player.current_animation_position
	animation_player.stop()
	if side == "left":
		animation_player.play("backstab_left")
		animation_player.seek(curr_animation_time)
	else:
		animation_player.play("backstab_right")
		animation_player.seek(curr_animation_time)
	

func _on_body_entered(body: Node2D) -> void:
	# checking if the swing is actually hitting an enemy and checking if it has the "incoming_damage" method
	if body.is_in_group(GameManager.ENEMY_GROUP) && body.has_method("incoming_damage"):
		#calling the "incoming_damage" method inside the enemy object
		body.call_deferred("incoming_damage", damage)
	# disabling the collision for the sword
	collision_shape_2d.set_deferred("set_disabled", true)
