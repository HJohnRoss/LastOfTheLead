extends CharacterBody2D



@onready var marker_head: Marker2D = $Node2D/MarkerHead
@onready var marker_head_2: Marker2D = $Node2D/MarkerHead2
@onready var marker_feet: Marker2D = $Node2D/MarkerFeet
@onready var marker_feet_2: Marker2D = $Node2D/MarkerFeet2
@onready var DeathMarker: Marker2D = $Node2D/DeathMarker
@onready var tree : AnimationTree = $Player_Animation_Tree
@onready var animationPlayer : AnimationPlayer = $Player_Animation
@onready var mask4 : Timer = $Timer

@export var backstab: PackedScene

const GRAVITY: float = 1000.0
const RUN_SPEED: float = 240.0
const MAX_FALL: float = 800.0
const HURT_TIME: float = 0.3
const JUMP_VELOCITY: float = -625.0

var rolling = 0
var crouching = 0
var dead = false
var permeable = true

func _ready() -> void:
	# setting up the global variables for raytracers
	tree.active = true
	GameManager.MARKER_FEET = marker_feet
	GameManager.MARKER_HEAD = marker_head
	GameManager.MARKER_FEET_2 = marker_feet_2
	GameManager.MARKER_HEAD_2 = marker_head_2
	GameManager.DEATH_MARKER = DeathMarker
	GameManager.Spawn_Point = get("position")
	
func _process(_delta: float) -> void:

	set_collision_mask_value(4, permeable)
	if dead:
		tree.set("parameters/TimeScale/scale", 2)
		tree.set("parameters/Ground_h/transition_request", "Death")
		set_physics_process(false)
		set_process(false)
	else:
		tree.set("parameters/TimeScale/scale", 1)
		if rolling == 0:
			if velocity.x > 0 || velocity.x < 0:
				tree.set("parameters/Ground_h/transition_request", "Run")
			else:
				tree.set("parameters/Ground_h/transition_request", "Idle")
		elif rolling == 1:
			tree.set("parameters/Ground_h/transition_request", "Roll")
		elif rolling == 2:
			tree.set("parameters/Ground_h/transition_request", "Unroll")
		
		if crouching == 1:
			tree.set("parameters/Ground_h/transition_request", "Crouch")
		elif crouching == 2:
			tree.set("parameters/Ground_h/transition_request", "Stand")
		# disabling the player when ded
		# TODO get dead screen and checkpoints per level
		if !is_on_floor():
			if rolling == 0:
				if(velocity.y < 0):
					tree.set("parameters/Ground_h/transition_request", "Jump")
				else:
					tree.set("parameters/Ground_h/transition_request", "Fall")
	if GameManager.PLAYER_HEALTH <= 0:
		dead = true

func _physics_process(delta: float) -> void:
	# updating the position of the weapon (im convinced there is a better way)
	#TODO !IMPORTANT find a better way of doing this
	# if player is in the air, if so add gravity
	if !is_on_floor():
		velocity.y += GRAVITY * delta

	get_input()
	move_and_slide()


func get_input() -> void:
	velocity.x = 0
	#player input
	
	if Input.is_action_just_pressed("Suicide"):
		dead = true
	
	if Input.is_action_pressed("Roll"):
		rolling = 1
	if rolling == 0:
		if Input.is_action_pressed("Down"):
			crouching = 1
		elif Input.is_action_pressed("left"):
			velocity.x = -RUN_SPEED
			$Player_Sprite.flip_h = 1

		elif Input.is_action_pressed("right"):
			velocity.x = RUN_SPEED
			$Player_Sprite.flip_h = 0
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		if Input.is_action_pressed("Down"):
			permeable = false
			mask4.start()
		else:
			velocity.y = JUMP_VELOCITY
	
	# puts a min on the velocity and a max so gravity isnt wack
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)
	
	if Input.is_action_just_released("Roll"):
		rolling = 2
	
	if Input.is_action_just_released("Down"):
		crouching = 2
	

func _on_player_animation_tree_animation_finished(anim_name):
	if anim_name == "Unroll":
		rolling = 0
	if anim_name == "Stand":
		crouching = 0
	if anim_name == "Death":
		dead = false
		set_physics_process(true)
		set_process(true)
		visible = true
		GameManager.Spawn_Player = true
		GameManager.PLAYER_HEALTH = 10


func _on_timer_timeout():
	permeable = true
