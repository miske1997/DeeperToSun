extends Node2D

@onready var sprite := $Sprite2D

var roomType: Enums.RoomType
var roomSpriteFolder = "res://Assets/RoomIndicators/"

func _ready() -> void:
	match roomType:
		Enums.RoomType.SPAWN: sprite.texture = load(roomSpriteFolder + "NormalRoom.png")
		Enums.RoomType.TRAP: sprite.texture = load(roomSpriteFolder + "ChestTrapRoom.png")
		Enums.RoomType.THRONE: sprite.texture = load(roomSpriteFolder + "EventRandomRoom.png")
		Enums.RoomType.SHOP: sprite.texture = load(roomSpriteFolder + "ShopRoom.png")
		Enums.RoomType.BOSS: sprite.texture = load(roomSpriteFolder + "BossRoom.png")
		Enums.RoomType.ITEM: sprite.texture = load(roomSpriteFolder + "ChestTrapRoom.png")
		Enums.RoomType.EVENT: sprite.texture = load(roomSpriteFolder + "EventRoom.png")
		Enums.RoomType.SURVIVE: sprite.texture = load(roomSpriteFolder + "SurviveRoom.png")



func _on_area_2d_body_entered(body: Node2D) -> void:
	LevelTransition.LeaveRoom()
