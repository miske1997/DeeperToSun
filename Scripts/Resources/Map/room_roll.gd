class_name RoomRoll extends Resource

@export var roomConfig: RoomConfig  : get = get_room
@export var roll: Vector2

func get_room():
	return roomConfig
