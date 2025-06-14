extends Control

func open():
	print("works")
	Global.in_menu = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func exit():
	Global.in_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false


func _on_resume_pressed() -> void:
	exit()


func _on_quit_pressed() -> void:
	Global.close()
