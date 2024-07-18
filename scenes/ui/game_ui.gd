extends Control

@onready var reload_timer: Timer = $ReloadTimer
@onready var shadow_reload_timer: Label = $MarginContainer/HBoxContainer/ShadowReloadTimer
@onready var health_label: Label = $MarginContainer/HBoxContainer2/HealthLabel


var reload_time: int = 12

func _ready() -> void:
	health_label.text = str(GameManager.PLAYER_HEALTH) + " HP"
	
	SignalManager.shadow_reload.connect(reloading)
	SignalManager.player_lose_health.connect(player_lose_health)

func _process(delta: float) -> void:
	health_label.text = str(GameManager.PLAYER_HEALTH) + " HP"
	

func reloading() -> void:
	shadow_reload_timer.show()
	reload_timer.start()

func _on_reload_timer_timeout() -> void:
	reload_time -= 1
	shadow_reload_timer.text = str(reload_time)
	if reload_time == 0:
		reload_timer.stop()
		reload_time = 12
		shadow_reload_timer.hide()

func player_lose_health() -> void:
	health_label.text = str(GameManager.PLAYER_HEALTH) + " HP"
