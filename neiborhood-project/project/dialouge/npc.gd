extends CharacterBody3D


func interacted():
	if $dialouge.visible:
		$dialouge.exit()
	else:
		$dialouge.open()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("next"):
		if $dialouge.visible == true:
			$dialouge.next_line()
