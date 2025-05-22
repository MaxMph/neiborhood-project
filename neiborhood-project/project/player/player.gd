extends CharacterBody3D


var SPEED = 5.0
var base_speed = 5.0
var speed_mod = 0.0
var speed_mult = 1

var sprint_speed = 1.4

const JUMP_VELOCITY = 4.5
var fric = 0.3
var fric_mod = 0
var acc = 30

var fov = 75
var base_fov = 75
var fov_mod = 0

var leaning_l = false
var leaning_r = false
var leaning = false
var leanspeed = 3

var sense = 0.003

var extracting = false

#stats
var max_health = 100
var health = 100
@onready var stamina_bar = $"hud and UI/Control/hud/staminabar"

var shots_fired = 0

#noderef
@onready var head: Node3D = $"cam-holder/head"
@onready var cam = $"cam-holder/head/lean_goal/cam"

@onready var inventory = $inventory


@onready var primary_slot = load("res://project/scripts/items/guns/ak 47.tres")
@onready var aim_marker = $"cam-holder/head/lean_goal/cam/gun_holder/aim_Marker"
@onready var aim_holder = $"cam-holder/head/lean_goal/cam/gun_holder/aim_holder"
@onready var firerate_timer = $"cam-holder/head/lean_goal/cam/gun_holder/aim_holder/sub_aimholder/firerate_timer"
var aimholder_basepos = Vector3(0.0, 0.124, -0.044)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	gun_set()
	load_inv_from_global()

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		fric_mod = 0.2
	else:
		fric_mod = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and Global.in_menu == false:
		velocity = velocity.move_toward(Vector3(direction.x * (SPEED * speed_mult + speed_mod), velocity.y, direction.z * (SPEED * speed_mult + speed_mod)), acc * delta)
	else:
		velocity = velocity.move_toward(Vector3(0, velocity.y, 0), fric - fric_mod)
	
	speed_mod = 0
	
	#print(stamina_bar.value)
	#not working
	if Input.is_action_pressed("sprint") and stamina_bar.value > 0 and leaning == false:
		stamina_bar.value -= 28 * delta
		speed_mult = 1.5
		fov_mod = move_toward(fov_mod, sprint_speed, 10 * delta)
	else:
		speed_mult = move_toward(speed_mult, 1.0, 10 * delta)
		#speed_mult = 1.0
		fov_mod = move_toward(fov_mod, 1.0, 10 * delta)
		if stamina_bar.value < stamina_bar.max_value:
			stamina_bar.value += 10 * delta
	
	if Input.is_action_pressed("aim") and Global.in_menu == false:
		aim_holder.position = aim_holder.position.move_toward(aim_marker.position, 4 * delta)
		fov = move_toward(fov, base_fov - primary_slot.fov_mod, 80 * delta)
	elif aim_holder.position != aimholder_basepos:
		aim_holder.position = aim_holder.position.move_toward(aimholder_basepos, 4 * delta)
		fov = move_toward(fov, base_fov, 80 * delta)
		#aim_holder.position = move_toward(aim_holder.position, aimholder_basepos, 10 * delta)
	
	if Input.is_action_just_pressed("shoot") and primary_slot.semi_auto == false and Global.in_menu == false:
		shoot()

	if Input.is_action_pressed("shoot") and primary_slot.semi_auto == true and Global.in_menu == false:
		shoot()

	if Input.is_action_just_pressed("reload") and $"reload timer".is_stopped() == true:
		$"reload timer".start()
		await $"reload timer".timeout
		shots_fired = 0
		print("reloaded")

	if Input.is_action_just_pressed("swap gun"):
		gun_set()

	if Input.is_action_pressed("lean left"):
		lean(1, delta)
		leaning_l = true
	else:
		leaning_l = false

	if Input.is_action_pressed("lean right"):
		lean(-1, delta)
		leaning_r = true
	else:
		leaning_r = false

	if leaning_l == false and leaning_r == false:
		leaning = false
		$"cam-holder/head/lean_goal".rotation.z = move_toward($"cam-holder/head/lean_goal".rotation.z, 0, leanspeed * delta)
		#cam.rotation.z = move_toward(cam.rotation.z, 0, leanspeed * delta)
		#$"cam-holder".position = $"cam-holder".position.move_toward(Vector3.ZERO, 6 * delta)
		#rotation_degrees.z = move_toward(rotation_degrees.z, 0, 80 * delta)

	if extracting == true:
		$"hud and UI/Control/hud/extract_timer".text = str(1 + roundi($"hud and UI/Control/hud/extract_timer/extract_timer".time_left))
	
	Global.inv_items = $inventory.items
	$CollisionShape3D.global_rotation = $"cam-holder/head/lean_goal".global_rotation
	$CollisionShape3D.global_position = $"cam-holder/head/lean_goal/MeshInstance3D".global_position
	$"hud and UI/Control/hud/ammo label".text = str(primary_slot.mag_cap - shots_fired) + "/" + str(primary_slot.mag_cap)
	cam.fov = fov + fov_mod
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * sense)
			cam.rotate_x(-event.relative.y * sense)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-75), deg_to_rad(75))

func shoot():
	if shots_fired < primary_slot.mag_cap:
		if firerate_timer.is_stopped() == true:
			get_node(str(primary_slot.model)).shoot()
			firerate_timer.start()
			shots_fired += 1

func hit(dmg):
	print("works")
	health -= dmg
	$"hud and UI/Control/hud/healthbar".value = health
	if health <= 0:
		queue_free()

func gun_set():
	if primary_slot == $"cam-holder/head/lean_goal/cam/gun_holder/aim_holder/sub_aimholder/pistol".res:
		primary_slot = $"cam-holder/head/lean_goal/cam/gun_holder/aim_holder/sub_aimholder/AK 47".res
	else:
		primary_slot = $"cam-holder/head/lean_goal/cam/gun_holder/aim_holder/sub_aimholder/pistol".res
	for i in $"cam-holder/head/lean_goal/cam/gun_holder/aim_holder/sub_aimholder".get_children():
		if i != firerate_timer:
			i.visible = false
	get_node(str(primary_slot.model)).visible = true
	firerate_timer.wait_time = primary_slot.firerate * 0.006
	shots_fired = 0

func lean(dir, delta):
	leaning = true
	$"cam-holder/head/lean_goal".rotation.z = move_toward($"cam-holder/head/lean_goal".rotation.z, 0.4 * dir, leanspeed * delta)
	speed_mod = -2
	#pass
	#cam.rotation.z = move_toward(cam.rotation.z, 0.4 * dir, leanspeed * delta)
	#$"cam-holder".rotation = cam.rotation.z * 0.4
	#$"cam-holder".rotation = head.transform.basis * Vector3(dir * -0.4, 0, 0)#($"cam-holder".rotation.z 0.4 * dir) * 
	#$"cam-holder".rotation.z = 0.4 * dir #$"cam-holder".rotation - head.transform.basis * Vector3(0, 0 ,dir)
	#$"cam-holder".position =  $"cam-holder".position.move_toward(head.transform.basis * Vector3(dir * -0.4, 0, 0), 6 * delta)
	#$"cam-holder".rotation.move_toward(head.transform.basis * Vector3.RIGHT, 0.6, 80 * delta)
	#
	#$CollisionShape3D.rotation.move_toward($CollisionShape3D.rotation * cam.rotation, 0.6, 80 * delta)
	#rotate_object_local(transform.basis.z, 15 * dir)
	#rotation = rotation.move_toward(cam.global_rotation, 80 * delta)

func extract(start: bool):
	if start == true:
		extracting = true
		$"hud and UI/Control/hud/extract_timer".visible = true
		if $"hud and UI/Control/hud/extract_timer/extract_timer".is_stopped():
			$"hud and UI/Control/hud/extract_timer/extract_timer".start()
	else:
		extracting = false
		$"hud and UI/Control/hud/extract_timer".visible = false
		$"hud and UI/Control/hud/extract_timer/extract_timer".stop()

func _on_extract_timer_timeout() -> void:
	Global.inv_items = inventory.items
	get_tree().change_scene_to_file("res://project/hub.tscn")

func load_inv_from_global():
	inventory.items = Global.inv_items
