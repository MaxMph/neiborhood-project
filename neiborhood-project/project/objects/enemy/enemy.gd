extends CharacterBody3D

var health = 60
@export var gun: gun_res
@onready var _gun = $head/pistol
var shots_fired = 0

var target_pos
var look_speed = 0
var opp
var opp_last
var opp_super_last
var rand_pos

@onready var firerate_timer = $firerate_timer

@onready var dropbox = preload("res://project/item_sack.tscn")
@export var droploot: Array[Resource] = []
@onready var main = get_tree().get_root().get_node("Main")

var tracking = false


func _ready() -> void:
	target_pos = global_position
	droploot.append(load("res://project/scripts/items/other/Gold Watch.tres"))


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if tracking:
		look_for(delta)
		if opp != null:
			$proberay.look_at(opp.global_position)
			if $proberay.is_colliding() and $proberay.get_collider().is_in_group("player"):
				pass
			elif $proberay/Timer.is_stopped():
				$proberay/Timer.start()
		
	
	$MeshInstance3D2.global_position = target_pos
	move_and_slide()

func hit(dmg):
	health -= dmg
	if health <= 0:
		die()
	$hit.play()

func die():
	print(droploot)
	if droploot.is_empty() == false:
		print("instance")
		var new_box = dropbox.instantiate()
		new_box.items = droploot
		new_box.global_transform = global_transform
		main.add_child.call_deferred(new_box)
	queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		opp = body
		opp_last = opp.global_position
		opp_super_last = opp_last
		tracking = true
		

func look_for(delta):
	rand_pos = randi_range(-1, 1)
	look_speed = target_pos.distance_to(opp_super_last) * 3
	target_pos = target_pos.move_toward(opp_super_last + Vector3(rand_pos, rand_pos, rand_pos), (3 + look_speed) * delta)
	$head.look_at(target_pos)
	opp_super_last = opp_last
	opp_last = opp.global_position
	
	shoot()

func shoot():
	if shots_fired < gun.mag_cap:
		if firerate_timer.is_stopped() == true:
			_gun.shoot()
			firerate_timer.start()
			shots_fired += 1
	else:
		reload()

func reload():
	await get_tree().create_timer(1).timeout
	shots_fired = 0
	


func _on_timer_timeout() -> void:
	print("timeout")
	if $proberay.is_colliding() and $proberay.get_collider().is_in_group("player"):
		pass
	else:
		tracking = false
