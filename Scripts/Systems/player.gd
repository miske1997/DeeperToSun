class_name Player extends CharacterBody2D

@export var playerConfig: PlayerConfig
@export var playerData: PlayerData
var health: int
var iframes = false

signal takeDamage

func _ready() -> void:
	if not playerData:
		init_player_data()
	
func init_player_data():
	playerData = PlayerData.new()
	playerData.stats = StatManager.new()
	playerData.stats.InitFromConfig(playerConfig)
	
