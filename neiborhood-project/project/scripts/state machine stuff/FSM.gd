extends Node

var states : Dictionary = {}
@export var initial_state: state

func _ready() -> void:
	for child in get_children():
		if is State:
			states[child.name.to_lower()] = child
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
