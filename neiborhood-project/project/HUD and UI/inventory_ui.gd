extends TabContainer

@onready var inv = $"../../../inventory"




func _on_tab_changed(tab: int) -> void:
#	var newlabel = Label.new()
#	newlabel.text = "hunger + 10"
#	$Consumables/panelcontainer/MarginContainer/VBoxContainer.add_child(Label.new())
	$Consumables/panelcontainer/MarginContainer/VBoxContainer/effect1.text = "hunger + 10"
	$Consumables/panelcontainer/MarginContainer/VBoxContainer/effect1.visible = true


func build_collection(items):
	$Weapons/ItemList.clear()
	$Consumables/ItemList.clear()
	$Other/ItemList.clear()
	for i in items:
		if i.is_gun:
			$Weapons/ItemList.add_item(i.name)
		elif i.is_consumable:
			$Consumables/ItemList.add_item(i.name)
		else:
			$Other/ItemList.add_item(i.name)
		

func interacted():
	if visible == false:
		if Global.in_menu == false:
			visible = true
			Global.in_menu = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		visible = false
		Global.in_menu = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func exit():
	visible = false
	Global.in_menu = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
