extends Node

@export var roomConfig: ShopRoom
@export var shopManager: Node2D
var mapNode: MapNode

func _ready() -> void:
	if not roomConfig:
		return
	shopManager.rollShop(roomConfig.dropTable)

func _on_exit_trigger_body_entered(body: Node2D) -> void:
	LevelTransition.LeaveRoom()
