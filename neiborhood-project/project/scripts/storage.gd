extends Control

@onready var itemlist = $VBoxContainer/PanelContainer/HSplitContainer/ItemList

#info
@onready var dmg_info = $VBoxContainer/PanelContainer/HSplitContainer/panelcontainer/MarginContainer/VBoxContainer/dmg
@onready var firerate_info = $VBoxContainer/PanelContainer/HSplitContainer/panelcontainer/MarginContainer/VBoxContainer/firerate
@onready var ammo_info = $VBoxContainer/PanelContainer/HSplitContainer/panelcontainer/MarginContainer/VBoxContainer/Ammo
@onready var weight_info = $VBoxContainer/PanelContainer/HSplitContainer/panelcontainer/MarginContainer/VBoxContainer/value
@onready var value_info = $VBoxContainer/PanelContainer/HSplitContainer/panelcontainer/MarginContainer/VBoxContainer/weight

var gunstat_nodes:Array

func open():
	Global.in_menu = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	itemlist.select(0)
	display_info(0)

func exit():
	Global.in_menu = false
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _ready() -> void:
	if get_parent().items != null:
		for i in get_parent().items:
			itemlist.add_item(i.name)
	gunstat_nodes = get_tree().get_nodes_in_group("gun_stat")


func _on_grab_pressed() -> void:
	grab()
	#for i in itemlist.get_selected_items():
		#get_tree().get_first_node_in_group("player").inventory._add(get_parent().items[i])
		#get_parent().items.remove_at(i)
		#itemlist.remove_item(i)

func grab():
	var cur_sel
	for i in itemlist.get_selected_items():
		get_tree().get_first_node_in_group("player").inventory._add(get_parent().items[i])
		get_parent().items.remove_at(i)
		cur_sel = i
		itemlist.remove_item(i)
	if cur_sel < itemlist.item_count:
		itemlist.select(cur_sel)
		print("works")
	elif cur_sel == itemlist.item_count:
		itemlist.select(cur_sel - 1)
	#if cur_sel < itemlist.item_count:
		#itemlist.select(cur_sel + 1)
		#
	#elif cur_sel > 0:
		#itemlist.select(cur_sel -1)
	#print(itemlist.item_count)

func _on_grab_all_pressed() -> void:
	itemlist.clear()
	for i in get_parent().items:
		get_tree().get_first_node_in_group("player").inventory._add(i)


func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	display_info(index)
	if $VBoxContainer/PanelContainer/HSplitContainer/ItemList/Timer.is_stopped() == false:
		grab()
	else:
		$VBoxContainer/PanelContainer/HSplitContainer/ItemList/Timer.start()

func display_info(index):
	var item = get_parent().items[index]
	for i in gunstat_nodes:
		i.visible = false
		
		
		value_info.value.text = str(item.value)
		weight_info.value.text = str(item.weight)
		
		
	if item.is_gun == true:
		dmg_info.value.text = str(item.dmg)
		firerate_info.value.text = str(item.firerate)
		ammo_info.value.text = str(item.mag_cap)
		for i in gunstat_nodes:
			i.visible = true
	
	#if item.is_consumable:
		#for i in item.effects:
			
