class_name RoomNode extends Resource

##the config that the room will use
@export var roomConfig: RoomConfig
##the nodes the map node is connected to
@export var adjacentNodes: Array[NodePath] = []
