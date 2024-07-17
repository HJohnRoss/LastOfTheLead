extends PointLight2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var ray_cast_2d_2: RayCast2D = $RayCast2D2
@onready var ray_cast_2d_3: RayCast2D = $RayCast2D3

var player
const red = Color(1, 0, 0)
const white = Color(1, 1, 1)

func _process(delta: float) -> void:
	player_in_light()
	look_at(player.global_position)

func player_in_light():
	var space_state = get_world_2d().direct_space_state
	color = white
	if player:
		get_positions()
		ray_cast_2d.look_at(GameManager.MARKER_FEET.global_position)
		ray_cast_2d_2.look_at(GameManager.MARKER_HEAD.global_position)
		ray_cast_2d_3.look_at(player.global_position)
		if ray_cast_2d.is_colliding() && ray_cast_2d.get_collider().name == "Player":
			color = red
		elif ray_cast_2d_2.is_colliding() && ray_cast_2d_2.get_collider().name == "Player":
			color = red
		elif ray_cast_2d_3.is_colliding() && ray_cast_2d_3.get_collider().name == "Player":
			color = red

func get_positions() -> Dictionary:
	var positions = {
	}
	
	return positions

func _on_area2D_body_entered(body):
	if body.name == 'Player':
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player = null
