extends PointLight2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
@onready var ray_cast_2d_3: RayCast2D = $RayCast2D3
@onready var ray_cast_2d_4: RayCast2D = $RayCast2D4
@onready var ray_cast_2d_5: RayCast2D = $RayCast2D5



@onready var damage_timer: Timer = $DamageTimer

var player
const red = Color(1, 0, 0)
const white = Color(1, 1, 1, 0.2)

# if the player can take damage from this enemy
var is_damagable = true

func _process(_delta: float) -> void:
	player_in_light()
	#TODO change, add a pathing for enemys instead of looking


func player_in_light():
	# this was a pain
	color = white
	if player && is_damagable:
		# setting all the raytracers to keep track of the hitbox
		ray_cast_2d.look_at(GameManager.MARKER_FEET.global_position)
		ray_cast_2d_2.look_at(GameManager.MARKER_HEAD.global_position)
		ray_cast_2d_3.look_at(player.global_position)
		ray_cast_2d_4.look_at(GameManager.MARKER_FEET_2.global_position)
		ray_cast_2d_5.look_at(GameManager.MARKER_HEAD_2.global_position)

		# if the raycast is colliding and its colliding with the player
		#if ray_cast_2d.is_colliding() && ray_cast_2d.get_collider().name == "Player":
			#damage_player()
		#elif ray_cast_2d_2.is_colliding() && ray_cast_2d_2.get_collider().name == "Player":
			#damage_player()
		#elif ray_cast_2d_3.is_colliding() && ray_cast_2d_3.get_collider().name == "Player":
			#damage_player()
		#elif ray_cast_2d_4.is_colliding() && ray_cast_2d_4.get_collider().name == "Player":
			#damage_player()
		#elif ray_cast_2d_5.is_colliding() && ray_cast_2d_5.get_collider().name == "Player":
			#damage_player()


#func damage_player() -> void:
	##TODO make the red a animation so it can play for about 2 seconds
	#GameManager.PLAYER_HEALTH -= 1
	#color = red
	## makes the player not take damage
	#is_damagable = false
	## starting the timer till the player can take dmg again
	#damage_timer.start()
	## emiting to the ui to update player hp
	#SignalManager.player_lose_health.emit()
	


func _on_damage_timer_timeout() -> void:
	#making the player able to take damage again
	damage_timer.stop()
	is_damagable = true

func _on_area2D_body_entered(body):
	#saving the player object when it goes inside of the collision
	if body.name == 'Player':
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	#sets player to null when leaving the collision
	if body.name == "Player":
		player = null

