extends Node

@export var max_weight: int
var weight:int = 0
var overloaded = false

var items: Array = []

func _add(item):
	items.append(item)
	calc_weight()
	print(item.name)
	#for i in items:
		#print(i.name)
	

func _remove(item):
	for i in items:
		if i == item:
			items.erase(i)
	calc_weight()

func calc_weight():
	for i in items:
		weight = 0
		weight += i.weight
	if weight > max_weight:
		overloaded = true

func send_items():
	pass
	items.sort_custom(func(a, b): return a.value > b.value)
	$"../hud and UI/Control/inventory".build_collection(items)
