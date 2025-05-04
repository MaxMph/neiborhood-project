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

#noderef
@onready var head: Node3D = $"cam-holder/head"
@onready var cam = $"cam-holder/head/cam"

@onready var inventory = $inventory

@onready var primary_slot = load("res://project/scripts/items/guns/pistol.tres")
@onready var aim_marker = $"cam-holder/head/cam/gun_holder/aim_Marker"
@onready var aim_holder = $"cam-holder/head/cam/gun_holder/aim_holder"
var aimholder_basepos = Vector3(0.0, 0.124, -0.044)

func _ready() -> void:
	pass
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	
	print($"cam-holder/head/cam/gun_holder/aim_holder/pistol".position)
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
	if direction:
		velocity = velocity.move_toward(Vector3(direction.x * (SPEED * speed_mult + speed_mod), velocity.y, direction.z * (SPEED * speed_mult + speed_mod)), acc * delta)
	else:
		velocity = velocity.move_toward(Vector3(0, velocity.y, 0), fric - fric_mod)
	
	
	if Input.is_action_pressed("sprint"):
		speed_mult = 1.5
		fov_mod = move_toward(fov_mod, sprint_speed, 10 * delta)
	else:
		speed_mult = move_toward(speed_mult, 1.0, 0.1 * delta)
		speed_mult = 1.0
		fov_mod = move_toward(fov_mod, 1.0, 10 * delta)
	
	if Input.is_action_pressed("aim"):
		#aim_holder.position = aim_holder.position.move_toward(aim_marker.position, 4 * delta)
		aim_holder.position = aim_marker.position
		fov = move_toward(fov, base_fov - primary_slot.fov_mod, 80 * delta)
	elif aim_holder.position != aimholder_basepos:
		aim_holder.position = aim_holder.position.move_toward(aimholder_basepos, 4 * delta)
		fov = move_toward(fov, base_fov, 80 * delta)
		#aim_holder.position = move_toward(aim_holder.position, aimholder_basepos, 10 * delta)
	
	if Input.is_action_just_pressed("shoot"):
		#print(primary_slot.model)
		get_node(str(primary_slot.model)).shoot()
	
	cam.fov = fov + fov_mod
	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * sense)
			cam.rotate_x(-event.relative.y * sense)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-75), deg_to_rad(75))
