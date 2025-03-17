class_name Player extends CharacterBody2D

@export var playerConfig: PlayerConfig
@export var playerData: PlayerData
var health: int
var iframes = false

signal takeDamage

func _ready() -> void:
	while not Players.player:
		await get_tree().process_frame
	if not playerData:
		init_player_data()
	Players.player.character = self
	
func init_player_data():
	playerData = Players.player
	#playerData = PlayerData.new()
	#playerData.stats = StatManager.new()
	#playerData.stats.InitFromConfig(playerConfig)
	
