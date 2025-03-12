extends Node


@export var mapData: MapData
@export var walk := false
@export var startPan := true

@onready var mapGenerator = $MapGenerator
@onready var roomBuilder = $RoomBuilder
@onready var mapNodes = $MapNodes
@onready var camera = $Camera2D

var player: Sprite2D
var playerMapNode: MapNode
var playerOffset: Vector2

func _ready() -> void:
	draw_map()
	
func draw_map():
	#GameData.saveData = ResourceLoader.load("user://Saves/" + GameData.slotInUse + ".tres")
	if GameData.saveData:
		mapData = GameData.saveData.mapData
		GameData.mapData = mapData
	if mapData:
		mapGenerator.GenerateMapFromData(mapData)
		playerMapNode = get_node(mapData.playerMapNode)
		spawn_player(mapData.playerPosition)
	else:
		mapGenerator.GenerateMapFromNodes(mapNodes)
		spawn_player($PlayerSpawn.position)
		playerMapNode = get_tree().get_first_node_in_group("StartRoom")
	
	playerOffset = player.position - playerMapNode.position
	
func spawn_player(position: Vector2):
	player = Sprite2D.new()
	player.texture = load("res://Assets/Characters/Archer.png")
	player.scale *= 0.7
	player.position = position
	add_child(player)
	
	camera.position = Vector2(camera.position.x, get_tree().get_first_node_in_group("BossRoom").position.y)
	await  get_tree().create_timer(0.6).timeout
	if startPan:
		focus_on_player(3)
	else:
		focus_on_player(0)
	

func move_player_request(newPosition: MapNode):
	if not is_node_connected_to(playerMapNode, newPosition):
		return
	await move_player(playerMapNode, newPosition)
	if not walk:
		LevelTransition.LoadRoom(newPosition, camera)
	#self.visible = false

func move_player(playerPosition: MapNode, newPosition: MapNode):
	var duration = (playerPosition.position - newPosition.position).length() / 500
	await get_tree().create_tween().tween_property(player, "position", newPosition.position + playerOffset, duration).finished
	playerMapNode = newPosition
	await focus_on_player(0.2)

func focus_on_player(duration: float):
	await get_tree().create_tween().tween_property(camera, "position", Vector2(camera.position.x, player.position.y), duration).finished

func is_node_connected_to(node: MapNode, connection: MapNode):
	for neighbourPath: NodePath in node.roomNode.adjacentNodes:
		var neighbour = node.get_node(neighbourPath)
		if neighbour == connection:
			return true
	return false
