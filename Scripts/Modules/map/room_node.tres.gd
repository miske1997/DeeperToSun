class_name MapNode extends Node2D

##The RoomNode configuration the game will use when the game is runing
@export var roomNode: RoomNode
##The data the node uses to roll the actual neighbours and RoomNode config
@export var nodeConfig: NodeConfig

@onready var sprite := $Sprite2D

var roomSpriteFolder = "res://Assets/RoomIndicators/"

func get_neighbours():
	var neighbours = []
	for neighbourPath in roomNode.adjacentNodes:
		neighbours.push_back(self.get_node(neighbourPath))
	return neighbours

func set_sprite():
	if not roomNode or not roomNode.roomConfig:
		return
	match roomNode.roomConfig.roomType:
		Enums.RoomType.SPAWN: sprite.texture = load(roomSpriteFolder + "NormalRoom.png")
		Enums.RoomType.TRAP: sprite.texture = load(roomSpriteFolder + "ChestTrapRoom.png")
		Enums.RoomType.THRONE: sprite.texture = load(roomSpriteFolder + "EventRandomRoom.png")
		Enums.RoomType.SHOP: sprite.texture = load(roomSpriteFolder + "ShopRoom.png")
		Enums.RoomType.BOSS: sprite.texture = load(roomSpriteFolder + "BossRoom.png")
		Enums.RoomType.ITEM: sprite.texture = load(roomSpriteFolder + "ChestTrapRoom.png")
		Enums.RoomType.EVENT: sprite.texture = load(roomSpriteFolder + "EventRoom.png")
		Enums.RoomType.SURVIVE: sprite.texture = load(roomSpriteFolder + "SurviveRoom.png")
	

func draw_connections():
	for neighbourPath: NodePath in roomNode.adjacentNodes:
		var neighbout: Node2D = get_node(neighbourPath)
		draw_line_segment(self, neighbout)
		
func draw_line_segment(from: Node2D, to: Node2D):
	var line = Line2D.new()
	var offset = (to.position - from.position) / 6
	line.add_point(offset)
	line.add_point(to.position - offset - from.position)
	line.default_color = Color(0,0,0)
	line.antialiased = true
	line.z_index = -10
	line.width = 3
	add_child(line)
	#draw_line(from.position + offset, to.position - offset, Color(0,0,0), true)
