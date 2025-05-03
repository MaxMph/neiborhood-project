extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var fric = 0.3
var fric_mod = 0
var acc = 30

var sense = 0.003

#noderef
@onready var head: Node3D = $"cam-holder/head"
@onready var cam = $"cam-holder/head/cam"

@onready var inventory = $inventory

func _ready() -> void:
	pass
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

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
	if direction:
		velocity = velocity.move_toward(Vector3(direction.x * SPEED, velocity.y, direction.z * SPEED), acc * delta)
	else:
		velocity = velocity.move_toward(Vector3(0, velocity.y, 0), fric - fric_mod)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * sense)
			cam.rotate_x(-event.relative.y * sense)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-75), deg_to_rad(75))
