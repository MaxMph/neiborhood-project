extends CharacterBody3D

@export var lines: Array[String] = []

func _ready() -> void:
	for l in lines:
		$dialouge.lines.append(l)

func interacted():
	if $dialouge.visible:
		$dialouge.exit()
	else:
		$dialouge.open()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next"):
		if $dialouge.visible == true:
			$dialouge.next_line()
