extends CSGBox3D

@onready var text_edit = $CanvasLayer/Control/PanelContainer/VBoxContainer/TextEdit
func interacted():
	$CanvasLayer.visible = true
	Global.in_menu = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#get_tree().change_scene_to_file("res://project/main.tscn")


func _on_close_pressed() -> void:
	$CanvasLayer.visible = false
	Global.in_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CanvasLayer/Control/PanelContainer/VBoxContainer/TextEdit.text = ""


func _on_enter_pressed() -> void:
	var inputcode: String = text_edit.text
	if inputcode.split()
		get_tree().change_scene_to_file("res://project/main.tscn")
