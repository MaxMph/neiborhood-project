extends Node3D

@export var anim_player: AnimationPlayer
@export var res: Resource
@onready var bullet = preload("res://project/objects/guns/bullet.tscn")
@onready var main = get_tree().get_root().get_node("Main")

func shoot():
	var new_bullet = bullet.instantiate()
	#new_bullet.transform = $bullet_marker.transform
	new_bullet.spawn_transform = $bullet_marker.global_transform
	#new_bullet.spawn_pos = $bullet_marker.global_position
	#new_bullet.spawn_rot = $bullet_marker.global_rotation
	new_bullet.dmg = res.dmg
	$bullet_marker/Sprite3D.rotation.z = randi_range(-20, 20)
	$AnimationPlayer.play("shoot")
	main.add_child.call_deferred(new_bullet)
