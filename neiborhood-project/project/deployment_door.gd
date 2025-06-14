extends CSGBox3D

@onready var text_edit = $CanvasLayer/Control/PanelContainer/VBoxContainer/TextEdit
@onready var invalid_warning = $CanvasLayer/Control/PanelContainer/VBoxContainer/Label
var valid = true
var id

func interacted():
	$CanvasLayer.visible = true
	Global.in_menu = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	invalid_warning.visible = false
	#get_tree().change_scene_to_file("res://project/main.tscn")


func _on_close_pressed() -> void:
	$CanvasLayer.visible = false
	Global.in_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	text_edit.text = ""

func _on_enter_pressed() -> void:
	invalid_warning.visible = false
	if decode() == true:
		_on_close_pressed()
		Global.drop_ids.append(id)
		get_tree().change_scene_to_file("res://world.tscn")
	else:
		text_edit.text = ""
		invalid_warning.visible = true

func decode():
	var inputcode: String = text_edit.text
	var decode = inputcode.split(" ")
	for i in decode:
		#if int(i) == null:
		if i.is_valid_int() == false:
			#print("abasdktaet")
			return false
	decode = decode.slice(3)
	if int(decode[0]) > 0 and int(decode[0]) < 4:
		Global.drop_location = int(decode[0])
	id = int(decode[1])
	if decode.size() != Global.drop_location + 2:
		#valid = false
		return false
	for i in Global.drop_ids:
		if i == id:
			return false
	
	return true

func finalize():
	pass
