class_name NodeConfig extends Resource

##list of posible neighbors to this Node
@export var posibleNeighbors: Array[RoomNode] = []
##list of mandatory neighbors to this Node
@export var mandatoryNeighbors: Array[RoomNode] = []
##list of rooms that can be selected for this node
@export var posibleRooms: Array[RoomRoll] = []
