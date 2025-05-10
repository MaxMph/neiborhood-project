extends Control

@export var lines: Array[String] = []
var line_index = 0


func _ready() -> void:
	next_line()

func open():
	visible = true
	Global.in_menu = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func exit():
	visible = false
	Global.in_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func next_line():
	line_index += 1
	if lines.size() > line_index:
		$VBoxContainer/PanelContainer/MarginContainer/RichTextLabel.text = lines[line_index]


func _on_continue_pressed() -> void:
	next_line()


func _on_exit_pressed() -> void:
	exit()
