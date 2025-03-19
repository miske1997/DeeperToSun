extends Node

var items_data = preload("res://Data/Items/items_data.tres").items
var item_functions = load("res://Data/Items/item_functions.tres")

func _ready() -> void:
	Events.itemCollected.connect(on_item_pickup)
	Events.itemBought.connect(on_item_bought)

func on_item_bought(itemName):
	add_item(itemName)

func on_item_pickup(itemOnGround):
	add_item(itemOnGround.itemName)
	itemOnGround.queue_free()

func add_item(itemName: String):
	var passiveItem = PassiveItem.new()
	passiveItem.name = itemName
	var item = items_data[itemName]
	if Players.player.collectedItems.any(func(i): return i.name == passiveItem.name):
		return
	Players.player.collectedItems.push_back(passiveItem)
	if item.procs == Enums.ItemProcs.PICKUP or item.procs == Enums.ItemProcs.ROOM_LOAD:
		item_functions[item.function + passiveItem.state].call({})
