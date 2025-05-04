extends Node3D

@export var anim_player: AnimationPlayer
@onready var bullet = preload("res://project/objects/guns/bullet.tscn")

func shoot():
	var new_bullet = bullet.instantiate()
	#get_tree().add_child()
	#get_tree().get_first_node_in_group("player").add_child()
	new_bullet.transform = $bullet_marker.transform
	$AnimationPlayer.play("shoot")
	add_child(new_bullet)
