extends Node


func GenerateMapFromData(mapData: MapData):
	for node in mapData.roomTree:
		DeSerializeNode(node)

func DeSerializeNode(roomSave: RoomSave):
	var node: MapNode = get_node(roomSave.nodePath)
	node.roomNode = roomSave.roomNode
	init_node(node)

func GenerateDataFromMap(mapNodes: Node2D):
	var startRoom: MapNode = get_tree().get_first_node_in_group("StartRoom")
	if not GameData.mapData:
		GameData.mapData = MapData.new()
		
	for group in mapNodes.get_children():
		for node: MapNode in group.get_children():
			GameData.mapData.roomTree.push_back(SerializeNode(node))
		

func SerializeNode(node: MapNode):
	var roomSave = RoomSave.new()
	roomSave.roomNode = node.roomNode
	roomSave.nodePath = node.get_path()
	return roomSave

func GenerateMapFromNodes(mapNodes: Node2D):
	for mapGroup in mapNodes.get_children():
		processNodeGroup(mapGroup)
	GenerateDataFromMap(mapNodes)
	

func processNodeGroup(group: Node2D):
	var selectedNodeTypes = []
	for node: MapNode in group.get_children():
		if node.roomNode and node.roomNode.roomConfig:
			init_node(node)
			continue
		proccessNode(node, selectedNodeTypes)
		
		
func proccessNode(node: MapNode, selectedNodeTypes):
	var roomConfig = rollRoom(node.nodeConfig.posibleRooms)
	if not node.roomNode:
		node.roomNode = RoomNode.new()
	
	node.roomNode.roomConfig = roomConfig
	init_node(node)

func rollRoom(posibleRooms: Array[RoomRoll]):
	var roll := randi_range(0, 1000)
	for nodeRoll: RoomRoll in posibleRooms:
		if roll >= nodeRoll.roll.x  and roll <= nodeRoll.roll.y:
			return nodeRoll.roomConfig
	return RoomConfig.new()

func init_node(node: MapNode):
	node.set_sprite()
	node.draw_connections()
