extends CharacterBody3D

@export var speed: float
@export var drag: float
@export var drop: float


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	velocity.z = speed
	velocity.y = drop * delta
	if speed > 0:
		speed -= drag * delta
