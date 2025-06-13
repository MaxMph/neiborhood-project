extends CSGBox3D

@onready var text_edit = $CanvasLayer/Control/PanelContainer/VBoxContainer/TextEdit
@onready var invalid_warning = $CanvasLayer/Control/PanelContainer/VBoxContainer/Label
var valid = true

func interacted():
	$CanvasLayer.visible = true
	Global.in_menu = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	invalid_warning.visible = true
	#get_tree().change_scene_to_file("res://project/main.tscn")


func _on_close_pressed() -> void:
	$CanvasLayer.visible = false
	Global.in_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	text_edit.text = ""


func _on_enter_pressed() -> void:
	invalid_warning.visible = false
	var inputcode: String = text_edit.text
	var decode = inputcode.split(" ")
	var id
	decode = decode.slice(3)
	Global.drop_location = int(decode[0])
	id = int(decode[1])
	print(decode)
	if decode.size() != Global.drop_location + 2:
		valid = false
		print(decode.size())
		print(Global.drop_location + 1)
	
	for i in Global.drop_ids:
		if i == id:
			valid = false
	
	if valid == true:
		Global.drop_ids.append(id)
		get_tree().change_scene_to_file("res://project/main.tscn")
	else:
		text_edit.text = ""
		$CanvasLayer/Control/PanelContainer/VBoxContainer/Label.visible = true
