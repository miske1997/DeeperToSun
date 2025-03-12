extends Node

var roomScene: PackedScene = preload("res://Scenes/room.tscn")
var transitionRect: ColorRect

func _ready() -> void:
	transitionRect = get_tree().get_first_node_in_group("TranisitionRect")

func CheckFolder():
	if not DirAccess.dir_exists_absolute(OS.get_user_data_dir() + "/Saves"):
		DirAccess.make_dir_absolute(OS.get_user_data_dir() + "/Saves")

func SaveGame():
	CheckFolder()
	if not GameData.saveData:
		GameData.saveData = SaveData.new()
	var map = get_tree().get_first_node_in_group("Map")
	GameData.saveData.mapData = GameData.mapData
	GameData.saveData.mapData.playerPosition = map.player.position
	GameData.saveData.mapData.playerMapNode = map.playerMapNode.get_path()
	ResourceSaver.save(GameData.saveData, "user://Saves/" + GameData.slotInUse + ".tres")

func LoadRoom(mapNode: MapNode, camera: Camera2D):
	await get_tree().create_tween().tween_property(transitionRect, 'material:shader_parameter/circle_size', 0.0, 0.5).finished
	var room = roomScene.instantiate()
	room.roomConfig = mapNode.roomNode.roomConfig
	room.mapNode = mapNode
	get_tree().root.add_child(room)
	camera.enabled = false
	
func LeaveRoom():
	var map = get_tree().get_first_node_in_group("Map")
	var room = get_tree().get_first_node_in_group("Room")
	room.queue_free()
	map.get_node("Camera2D").enabled = true
	SaveGame()
	
func SwitchRoom(mapNode: MapNode):
	pass
	
	
