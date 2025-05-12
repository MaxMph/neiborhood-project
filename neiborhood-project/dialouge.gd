extends Control

@export var lines: Array[String] = []
var line_index = 0
var interactions = 0
var restart_convo = true
func _ready() -> void:
	next_line()

func open():
	print(lines)
	interactions += 1
	visible = true
	Global.in_menu = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if restart_convo == true:
		line_index = 0
	next_line()

func exit():
	visible = false
	Global.in_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func next_line():
	if lines.size() > line_index:
		$VBoxContainer/PanelContainer/MarginContainer/RichTextLabel.text = lines[line_index]
	else:
		exit()
	line_index += 1


func _on_continue_pressed() -> void:
	next_line()


func _on_exit_pressed() -> void:
	exit()
