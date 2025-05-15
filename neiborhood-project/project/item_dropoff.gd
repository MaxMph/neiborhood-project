extends StaticBody3D

var value = 0
#var item_values:Array = []
var digits: Array = []
var encoded_values: Array = []
var final:String = ""
#var pre_reversed: Array = []
var key: Array = [-4, 8, 2, -3, 6, 1]
var index = 0

var decoded_value = ""

func interacted():
	if Global.in_menu == false:
		value = 0
		index = 0
		digits.clear()
		encoded_values.clear()
		for i in Global.inv_items:
			value += i.value
			#item_values.append(i.value)
		encode()
		#open()
	

func encode():
	#if item_values.size() != 0:
	if value > 0:
		for digit in str(value):
			digits.append(int(digit))
		#print(encoded_values)
	
	for i in digits:
		#i = i * key[index]
		encoded_values.append(i * key[index])
		if index < (key.size() - 1):
			index += 1
		else:
			index = 0
	encoded_values.reverse()
	encoded_values.append(10 - encoded_values.size())
	encoded_values.append(7 - Global.shipments_made * 7)
	print(encoded_values)
	#decode()
	Global.shipments_made += 1
	for i in encoded_values:
		final += str(i) + " "
	$CanvasLayer/Control/PanelContainer/RichTextLabel.text = final #str(encoded_values)
	open()

func decode():
	index = 0
	var decoded: Array = []
	encoded_values.remove_at(encoded_values.size() - 1)
	encoded_values.remove_at(encoded_values.size() - 1)
	encoded_values.reverse()
	for i in encoded_values:
		decoded.append(i / key[index])
		if index < (key.size() - 1):
			index += 1
		else:
			index = 0
	
	for i in decoded:
		decoded_value += str(i)
	
	print(decoded_value)

#1, 2, 4, 6
#
#6, 4, 2, 1
#
#
#1-6 = -5
#2-4 = -2
#4-2 =  2
#6-1 = 5
#
#-5, -2, 2, 5
#
#1-2 = -1
#2-4 = -2
#4-6 = -2
#6-0 = 6

func open():
	Global.in_menu = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$CanvasLayer/Control.visible = true

func exit():
	Global.in_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$CanvasLayer/Control.visible = false
