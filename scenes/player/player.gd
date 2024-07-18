extends CharacterBody2D

class_name Player 

@onready var reload_timer: Timer = $ReloadTimer
@onready var marker_head: Marker2D = $MarkerHead
@onready var marker_feet: Marker2D = $MarkerFeet
@onready var marker_head_2: Marker2D = $MarkerHead2
@onready var marker_feet_2: Marker2D = $MarkerFeet2

@export var GROUND_SHADOW: PackedScene

const GRAVITY: float = 1000.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 400.0
const HURT_TIME: float = 0.3
const JUMP_VELOCITY: float = -400.0

var is_reloaded: bool = true


func _ready() -> void:
	GameManager.MARKER_FEET = marker_feet
	GameManager.MARKER_HEAD = marker_head
	GameManager.MARKER_FEET_2 = marker_feet_2
	GameManager.MARKER_HEAD_2 = marker_head_2
	

func _process(delta: float) -> void:
	if GameManager.PLAYER_HEALTH <= 0:
		set_physics_process(false)
		set_process(false)

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta
	get_input()
	move_and_slide()
	
	if Input.is_action_just_pressed("left_click"):
		ground_shadow()


func get_input() -> void:
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
	if Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)

func ground_shadow() -> void:
	if is_reloaded == false:
		return

	var in_range = get_in_range()
	
	var new_ground_shadow = GROUND_SHADOW.instantiate()
	if get_parent() && in_range:
		get_parent().add_child(new_ground_shadow)
		new_ground_shadow.global_position = get_global_mouse_position()
		
		reload_timer.start()
		is_reloaded = false
		SignalManager.shadow_reload.emit()

func get_in_range() -> bool:
	var range = global_position - get_global_mouse_position()
	var params = {
		"x": range.x <= 200 && range.x >= -100,
		"y": range.x <= 200 && range.x >= -100
	}
	if params.x && params.y:
		return true
	return false


func _on_reload_timer_timeout() -> void:
	is_reloaded = true
