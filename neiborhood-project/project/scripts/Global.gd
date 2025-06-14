extends Node

var in_menu = false
var inv_items: Array = []
var player

var drop_location = 0
var drop_ids: Array = []

var shipments_made = 0
#@onready var input_manager = $"Player/input manager"


const save_location = "user://savefile.json"

var save_data: Dictionary = {
	"ids": [],
	"shipment_ids": 0,
}

func _exit_tree() -> void:
	_save()

func _ready() -> void:
	_load()

func _save():
	save_data.ids = drop_ids
	save_data.shipment_ids = shipments_made
	
	var savefile = FileAccess.open(save_location, FileAccess.WRITE)
	savefile.store_var(save_data.duplicate())
	savefile.close()

func _load():
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var loaded_save_data = data.duplicate()
		drop_ids = loaded_save_data.ids
		shipments_made = loaded_save_data.shipment_ids
		print(drop_ids)

func close():
	_save()
	get_tree().quit()
