extends Node


func GenerateMapFromData(mapData):
	pass
	
func GenerateMapFromNodes(mapNodes: Node2D):
	for mapGroup in mapNodes.get_children():
		processNodeGroup(mapGroup)
		
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
