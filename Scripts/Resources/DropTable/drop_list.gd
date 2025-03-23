class_name DropList extends Drop

@export var drops: Array[Resource]

func get_drop():
	return drops.pick_random()
