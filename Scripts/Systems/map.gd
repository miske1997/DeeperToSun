extends Node


@export var mapData: MapData
@onready var mapGenerator = $MapGenerator
@onready var roomBuilder = $RoomBuilder
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mapGenerator.GenerateMap(mapData)

func draw_map():
	pass

func move_player_request(playerPosition: RoomNode, newPosition: RoomNode):
	if not is_node_connected_to(playerPosition, newPosition):
		return
	move_player(playerPosition, newPosition)
	LevelTransition.LoadRoom(newPosition.roomConfig)

func move_player(playerPosition: RoomNode, newPosition: RoomNode):
	pass
	
func is_node_connected_to(node: RoomNode, connection: RoomNode):
	pass
