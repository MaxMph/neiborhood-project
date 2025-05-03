extends RigidBody3D

@export var items: Array[Resource] = []
#func _ready() -> void:
	#Global.player.connect()

func interacted():
	if $storage.visible == false:
		$storage.open()
	else:
		$storage.exit()
	
