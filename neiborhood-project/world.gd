extends Node3D


func _ready() -> void:
	var drop = Global.drop_location
	var posible_locations = get_tree().get_first_node_in_group("drop_holder").get_children()
	if drop == 1:
		$Player.global_position = $"1".global_position
