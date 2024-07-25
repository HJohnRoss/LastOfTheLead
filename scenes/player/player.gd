extends CharacterBody2D

class_name Player 

@onready var marker_head: Marker2D = $Node2D/MarkerHead
@onready var marker_head_2: Marker2D = $Node2D/MarkerHead2
@onready var marker_feet: Marker2D = $Node2D/MarkerFeet
@onready var marker_feet_2: Marker2D = $Node2D/MarkerFeet2
@onready var tree : AnimationTree = $Player_Animation_Tree

@onready var reload_timer: Timer = $ReloadTimer
@onready var marker_weapon_right: Marker2D = $MarkerWeaponRight
@onready var marker_weapon_left: Marker2D = $MarkerWeaponLeft

@export var backstab: PackedScene

const GRAVITY: float = 1000.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 400.0
const HURT_TIME: float = 0.3
const JUMP_VELOCITY: float = -400.0

var is_reloaded: bool = true
var new_backstab
var weapon_left = false

func _ready() -> void:
	# setting up the global variables for raytracers
	tree.active = true
	GameManager.MARKER_FEET = marker_feet
	GameManager.MARKER_HEAD = marker_head
	GameManager.MARKER_FEET_2 = marker_feet_2
	GameManager.MARKER_HEAD_2 = marker_head_2
	# making an instace of the weapon
	new_backstab = backstab.instantiate()
	add_child(new_backstab)
	
func _process(_delta: float) -> void:
	if weapon_left:
		new_backstab.global_position = marker_weapon_left.global_position
		$Player_Sprite.flip_h = 1
	else:
		new_backstab.global_position = marker_weapon_right.global_position
		$Player_Sprite.flip_h = 0
		
	if velocity.x > 0 || velocity.x < 0:
		tree.set("parameters/Ground_h/transition_request", "Run")
	else:
		tree.set("parameters/Ground_h/transition_request", "Idle")
	
	
	# disabling the player when ded
	# TODO get dead screen and checkpoints per level
	if GameManager.PLAYER_HEALTH <= 0:
		set_physics_process(false)
		set_process(false)

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
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
		weapon_left = true

		if new_backstab.animation_player.is_playing():
			new_backstab.swap_animation_side("left")
	elif Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
		weapon_left = false
		

		if new_backstab.animation_player.is_playing():
			new_backstab.swap_animation_side("right")
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# puts a min on the velocity and a max so gravity isnt wack
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)
	
	# weapon swing
	if Input.is_action_just_pressed("left_click"):
		new_backstab.swing(weapon_left)


#func ground_shadow() -> void:
	#if is_reloaded == false:
		#return
#
	#var in_range = get_in_range()
	#
	#var new_ground_shadow = GROUND_SHADOW.instantiate()
	#if get_parent() && in_range:
		#get_parent().add_child(new_ground_shadow)
		#new_ground_shadow.global_position = get_global_mouse_position()
		#
		#reload_timer.start()
		#is_reloaded = false
		#SignalManager.shadow_reload.emit()

#func get_in_range() -> bool:
	#var curr_range = global_position - get_global_mouse_position()
	#var params = {
		#"x": curr_range.x <= 200 && curr_range.x >= -100,
		#"y": curr_range.x <= 200 && curr_range.x >= -100
	#}
	#if params.x && params.y:
		#return true
	#return false

# might be useful if we make a ranged attack
# TODO need to decide
func _on_reload_timer_timeout() -> void:
	is_reloaded = true
