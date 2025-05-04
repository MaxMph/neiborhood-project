extends item_res
class_name gun_res

@export var model: NodePath

@export var dmg: int
@export var firerate: int
@export var mag_cap: int

@export var fov_mod:int

@export_category("mods")
@export var magazine: Resource
@export var muzzle: Resource
@export var scope: Resource
@export var underbarrel: Resource
@export var side: Resource
