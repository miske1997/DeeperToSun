class_name PlayerData extends Resource

@export var collectedItems: Array[ItemConfig] = []
@export var equppedItem: ItemConfig
@export var equppedConsumable: ItemConfig
@export var stats: StatManager
@export var name: String = "Dan"
@export var gold: int = 50
var health: int = 6
var shields: int = 2
var character: Player
var invertAim := false
