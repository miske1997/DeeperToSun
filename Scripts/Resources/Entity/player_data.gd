class_name PlayerData extends Resource

@export var collectedItems: Array[ItemConfig] = []
@export var equppedItem: ItemConfig : set = set_active_item
@export var equppedConsumable: ItemConfig : set = set_consumable_item
@export var stats: StatManager
@export var name: String = "Dan"
@export var gold: int = 50
var health: int = 6
var shields: int = 2
var character: Player
var invertAim := false

signal activeItemEquipped
signal consumableItemEquipped

func set_active_item(item):
	equppedItem = item
	activeItemEquipped.emit(item)

func set_consumable_item(item):
	equppedConsumable = item
	consumableItemEquipped.emit(item)
