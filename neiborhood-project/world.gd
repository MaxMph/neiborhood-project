extends Node3D


func _ready() -> void:
	var drop = Global.drop_location - 1
	var posible_locations = get_tree().get_first_node_in_group("drop_holder").get_children()
	$Player.global_position = posible_locations[drop].global_position
