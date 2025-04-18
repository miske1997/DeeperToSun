extends Node

@export var itemOnGround: PackedScene

var items_data = preload("res://Data/Items/items_data.tres")
var item_functions = load("res://Data/Items/item_functions.tres")

func _ready() -> void:
	Events.itemCollected.connect(on_item_pickup)
	Events.itemBought.connect(on_item_bought)

func on_item_bought(pedistal, item):
	
	if Players.player.gold < item.cost:
		return
	Players.player.gold -= item.cost
	if item.name == "Heart":
		Players.player.character.healthUp.emit(1)
		return
	elif item.name == "Shield":
		Players.player.character.shealdUp.emit(1)
		return
	pedistal.bought()
	process_by_type(item)

func on_item_pickup(itemOnGround):
	process_by_type(itemOnGround.item)
	itemOnGround.queue_free()

func process_by_type(item):
	if item is PassiveItem:
		passive_item_pickup(item)
	elif item is ActiveItem:
		active_item_pickup(item)
	else:
		consumable_item_pickup(item)

func passive_item_pickup(passiveItem):
	var item = items_data.get_item(passiveItem.name)
	if Players.player.collectedItems.any(func(i): return i.name == passiveItem.name):
		return
	Players.player.collectedItems.push_back(passiveItem)
	
	if get_tree().get_first_node_in_group("Room").roomConfig is ShopRoom:
		return
	if item.procs.has(Enums.ItemProcs.PICKUP):
		item_functions[item.procs[Enums.ItemProcs.PICKUP] + passiveItem.state].call({})
	if item.procs.has(Enums.ItemProcs.ROOM_LOAD):
		item_functions[item.procs[Enums.ItemProcs.ROOM_LOAD] + passiveItem.state].call({})

func consumable_item_pickup(consumableItem):
	if Players.player.equppedConsumable:
		dropItem(Players.player.equppedConsumable)
	Players.player.equppedConsumable = consumableItem

func active_item_pickup(activeItem):
	if Players.player.equppedItem:
		dropItem(Players.player.equppedItem)
	Players.player.equppedItem = activeItem

func dropItem(item):
	var itemPickup: Node2D = itemOnGround.instantiate()
	var player = get_tree().get_first_node_in_group("Player")
	itemPickup.position = player.position + Vector2(0, -20)
	itemPickup.scale = player.scale / 3
	itemPickup.item = item
	get_tree().root.add_child(itemPickup)
