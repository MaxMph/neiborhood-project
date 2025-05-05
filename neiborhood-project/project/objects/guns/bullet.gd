extends CharacterBody3D

@export var speed: float = 160.0
@export var drag: float = 1.0
@export var drop: float = 18.0

var dmg: float

@onready var ray = RayCast3D.new()

var spawn_transform
#var spawn_pos
#var spawn_rot
var last_pos



func _ready() -> void:
	add_sibling(ray)
	#ray.global_position = global_position
	
	global_transform = spawn_transform
	#global_position = spawn_pos
	#global_rotation = spawn_rot
	
	velocity = transform.basis * Vector3(0,0,-speed)
	last_pos = position
	ray.global_position = global_position
	await get_tree().create_timer(0.1).timeout
	$MeshInstance3D3.visible = true


func _process(delta: float) -> void:
	ray.target_position = global_position - ray.global_position
	ray.position = last_pos
	last_pos = position
	ray.force_raycast_update()
	
	velocity.y -= drop * delta
	
	if ray.is_colliding():
		if ray.get_collider().is_in_group("hittable"):
			ray.get_collider().hit(dmg)
		print("WHOOOOOOOOOOOO")
		ray.queue_free()
		#ray.get_collision_normal()
		queue_free()
	
	move_and_slide()
