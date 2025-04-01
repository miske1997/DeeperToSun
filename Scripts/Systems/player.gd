class_name Player extends CharacterBody2D

@export var playerConfig: PlayerConfig
@export var playerData: PlayerData

@export var items_data: Resource
@export var item_functions: Resource

var iframes = false
var dashing := false : set = set_dashing

signal takeDamage
signal healthUp
signal shealdUp

func _ready() -> void:
	playerData = PlayerData.new()
	while not Players.player:
		await get_tree().process_frame

	init_player_data()
	Players.player.character = self
	
func init_player_data():
	playerData = Players.player

	#playerData = PlayerData.new()
	#playerData.stats = StatManager.new()
	#playerData.stats.InitFromConfig(playerConfig)
	
func set_dashing(value: bool):
	dashing = value
	if has_node("Ghost"):
		get_node("Ghost").enabled = value
	for item in Players.player.collectedItems:
		if items_data.items[item.name].procs.has(Enums.ItemProcs.DASH):
			item_functions[items_data.items[item.name].procs[Enums.ItemProcs.DASH] + item.state].call({dashing = dashing, player = self})
	

	
