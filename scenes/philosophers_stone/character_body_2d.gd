extends CharacterBody2D

@onready var anim = $AnimationPlayer




func _physics_process(delta):
	# Add the gravity.
	pass


func _on_end_cutscene_body_entered(body):
	if body.name == "Player":
		anim.play("Break")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
