extends Node

@onready var opening = preload("res://scenes/MainMenu/text_box.tscn")


var opDialogLines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false


func start_dialog(position: Vector2, lines: Array[String]):
	print(lines)
	if is_dialog_active:
		return
		
	opDialogLines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialog_active = true
	
func _show_text_box():
	text_box = opening.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(opDialogLines[current_line_index])
	can_advance_line = false
	
func _on_text_box_finished_displaying():
	can_advance_line = true
	
func _unhandled_input(event):
	if(
		event.is_action_pressed("advance_dialog") &&
		is_dialog_active &&
		can_advance_line
	):
		text_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= opDialogLines.size():
			is_dialog_active = false
			current_line_index = 0
			return
		
		_show_text_box()
