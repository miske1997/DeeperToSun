class_name RoomRollList extends RoomRoll

@export var rooms: Array[RoomConfig]

func get_room():
	return rooms.pick_random()
