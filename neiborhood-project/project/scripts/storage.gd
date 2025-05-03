extends Control

@onready var itemlist = $VBoxContainer/PanelContainer/HSplitContainer/ItemList

func open():
	Global.in_menu = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func exit():
	Global.in_menu = false
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _ready() -> void:
	if get_parent().items != null:
		for i in get_parent().items:
			itemlist.add_item(i.name)


func _on_grab_pressed() -> void:
	for i in itemlist.get_selected_items():
		get_tree().get_first_node_in_group("player").inventory._add(get_parent().items[i])
		get_parent().items.remove_at(i)
		itemlist.remove_item(i)

func _on_grab_all_pressed() -> void:
	itemlist.clear()
	for i in get_parent().items:
		get_tree().get_first_node_in_group("player").inventory._add(i)


func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	display_info()

func display_info():
	pass
