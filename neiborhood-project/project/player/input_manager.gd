extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("Interact"):
		#emit_signal("interact_pressed")
		$"../cam-holder/head/cam/interaction ray".interact()

	if Input.is_action_just_pressed("escape"):
		get_tree().call_group("menu", "exit")
	
	if Input.is_action_just_pressed("Inventory"):
		$"../hud and UI/Control/inventory".interacted()
		$"../inventory".send_items()
