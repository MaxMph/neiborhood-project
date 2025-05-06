extends RayCast3D

var can_interact = false
var interacting = false
@onready var crosshair = $"../../../../hud and UI/Control/crosshair"

#func _ready() -> void:
	#connect("interact_pressed", interact())

func _process(delta: float) -> void:
	if is_colliding() and get_collider().is_in_group("interactable"):
		can_interact = true
		show_crosshair()
	else:
		hide_crosshair()

func interact():
	if can_interact and is_colliding():
		get_collider().interacted()

func show_crosshair():
	if Global.in_menu == false:
		crosshair.visible = true
	else:
		can_interact = false
		crosshair.visible = false

func hide_crosshair():
	crosshair.visible = false
	can_interact = false
