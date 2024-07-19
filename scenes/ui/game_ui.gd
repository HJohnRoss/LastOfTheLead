extends Control

@onready var reload_timer: Timer = $ReloadTimer
@onready var shadow_reload_timer: Label = $MarginContainer/HBoxContainer/ShadowReloadTimer
@onready var health_label: Label = $MarginContainer/HBoxContainer2/HealthLabel


var pause_menu = preload("res://scenes/pauseMenu/pause_menu.tscn")
var reload_time: int = 12


func _ready() -> void:
	# initializing hp text
	health_label.text = str(GameManager.PLAYER_HEALTH) + " HP"
	
	SignalManager.shadow_reload.connect(reloading)
	SignalManager.player_lose_health.connect(player_lose_health)
	
	var pause_instance = pause_menu.instantiate()
	add_child(pause_instance)
	
	for i in range(5):
		print("loop")
		


func _process(_delta: float) -> void:
	#TODO HAS TO BE A BETTER WAY MAN
	health_label.text = str(GameManager.PLAYER_HEALTH) + " HP"
	
	



func reloading() -> void:
	#TODO probably wont need if were not using "groundshadow" scene
	shadow_reload_timer.show()
	reload_timer.start()

func _on_reload_timer_timeout() -> void:
	#TODO probably wont need if were not using "groundshadow" scene
	reload_time -= 1
	shadow_reload_timer.text = str(reload_time)
	if reload_time == 0:
		reload_timer.stop()
		reload_time = 12
		shadow_reload_timer.hide()

func player_lose_health() -> void:
	#i wish this worked5
	health_label.text = str(GameManager.PLAYER_HEALTH) + " HP"
