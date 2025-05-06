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

var sense = 0.003

#stats
var max_health = 100
var health = 100
@onready var stamina_bar = $"hud and UI/Control/hud/staminabar"

var shots_fired = 0

#noderef
@onready var head: Node3D = $"cam-holder/head"
@onready var cam = $"cam-holder/head/cam"

@onready var inventory = $inventory

@onready var primary_slot = load("res://project/scripts/items/guns/pistol.tres")
@onready var aim_marker = $"cam-holder/head/cam/gun_holder/aim_Marker"
@onready var aim_holder = $"cam-holder/head/cam/gun_holder/aim_holder"
@onready var firerate_timer = $"cam-holder/head/cam/gun_holder/aim_holder/sub_aimholder/firerate_timer"
var aimholder_basepos = Vector3(0.0, 0.124, -0.044)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_node(str(primary_slot.model)).visible = true
	firerate_timer.wait_time = primary_slot.firerate * 0.006

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		fric_mod = 0.2
	else:
		fric_mod = 0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and Global.in_menu == false:
		velocity = velocity.move_toward(Vector3(direction.x * (SPEED * speed_mult + speed_mod), velocity.y, direction.z * (SPEED * speed_mult + speed_mod)), acc * delta)
	else:
		velocity = velocity.move_toward(Vector3(0, velocity.y, 0), fric - fric_mod)
	
	#print(stamina_bar.value)
	#not working
	if Input.is_action_pressed("sprint") and stamina_bar.value > 0:
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
	health -= dmg
	$"hud and UI/Control/hud/healthbar".value = health
	if health <= 0:
		queue_free()

func gun_set():
	pass
