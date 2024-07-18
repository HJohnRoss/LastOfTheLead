extends PointLight2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
@onready var ray_cast_2d_3: RayCast2D = $RayCast2D3
@onready var ray_cast_2d_4: RayCast2D = $RayCast2D4
@onready var ray_cast_2d_5: RayCast2D = $RayCast2D5

@onready var damage_timer: Timer = $DamageTimer

var player
const red = Color(1, 0, 0)
const white = Color(1, 1, 1)

var is_damagable = true

func _process(delta: float) -> void:
	player_in_light()
	look_at(player.global_position)

func player_in_light():
	var space_state = get_world_2d().direct_space_state
	color = white
	if player && is_damagable:
		ray_cast_2d.look_at(GameManager.MARKER_FEET.global_position)
		ray_cast_2d_2.look_at(GameManager.MARKER_HEAD.global_position)
		ray_cast_2d_3.look_at(player.global_position)
		ray_cast_2d_4.look_at(GameManager.MARKER_FEET_2.global_position)
		ray_cast_2d_5.look_at(GameManager.MARKER_HEAD_2.global_position)

		if ray_cast_2d.is_colliding() && ray_cast_2d.get_collider().name == "Player":
			damage_player(player)
		elif ray_cast_2d_2.is_colliding() && ray_cast_2d_2.get_collider().name == "Player":
			damage_player(player)
		elif ray_cast_2d_3.is_colliding() && ray_cast_2d_3.get_collider().name == "Player":
			damage_player(player)
		elif ray_cast_2d_4.is_colliding() && ray_cast_2d_4.get_collider().name == "Player":
			damage_player(player)
		elif ray_cast_2d_5.is_colliding() && ray_cast_2d_5.get_collider().name == "Player":
			damage_player(player)

func _on_area2D_body_entered(body):
	if body.name == 'Player':
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null

func damage_player(player) -> void:
	GameManager.PLAYER_HEALTH -= 1
	color = red
	is_damagable = false
	damage_timer.start()
	SignalManager.player_lose_health.emit()


func _on_damage_timer_timeout() -> void:
	damage_timer.stop()
	is_damagable = true
