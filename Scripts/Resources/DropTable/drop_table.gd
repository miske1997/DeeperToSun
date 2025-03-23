class_name DropTable extends Resource

@export var enteries: Array[Drop]

func get_drop():
	var roll = randi_range(0, 1000)
	for entry in enteries:
		if roll >= entry.dropChance.x and roll <= entry.dropChance.y:
			return entry.get_drop()
