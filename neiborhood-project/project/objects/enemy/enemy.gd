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

@onready var firerate_timer = $firerate_timer


var tracking = false


func _ready() -> void:
	target_pos = global_position


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if tracking:
		look_for(delta)
		
	
	$MeshInstance3D2.global_position = target_pos
	move_and_slide()

func hit(dmg):
	health -= dmg
	if health <= 0:
		queue_free()
	$hit.play()


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		opp = body
		opp_last = opp.global_position
		opp_super_last = opp_last
		tracking = true
		

func look_for(delta):
	look_speed = target_pos.distance_to(opp_super_last) * 3
	target_pos = target_pos.move_toward(opp_super_last, (3 + look_speed) * delta)
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
	
