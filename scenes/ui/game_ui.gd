extends Control

@onready var shadow_reload_timer: Label = $MarginContainer/VBoxContainer/ShadowReloadTimer
@onready var reload_timer: Timer = $ReloadTimer

var reload_time: int = 12

func _ready() -> void:
	SignalManager.shadow_reload.connect(reloading)

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
