extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const damage = 1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#   connecting the swing_sword signal to the swing_sword function
	SignalManager.swing_sword.connect(swing_sword)

func swing_sword() -> void:
	# enabling the collision for the sword and playing the animation
	collision_shape_2d.set_disabled(false)
	animation_player.play("backstab")

func _on_body_entered(body: Node2D) -> void:
	# checking if the swing is actually hitting an enemy and checking if it has the "incoming_damage" method
	if body.is_in_group(GameManager.ENEMY_GROUP) && body.has_method("incoming_damage"):
		#calling the "incoming_damage" method inside the enemy object
		body.call_deferred("incoming_damage", damage)
	# disabling the collision for the sword
	collision_shape_2d.set_deferred("set_disabled", true)
