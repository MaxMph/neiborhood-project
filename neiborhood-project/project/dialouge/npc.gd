extends CharacterBody3D


func interacted():
	if $dialouge.visible:
		$dialouge.exit()
	else:
		$dialouge.open()
