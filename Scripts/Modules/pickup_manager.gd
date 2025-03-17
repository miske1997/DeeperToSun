extends Node

@export var items_data: Resource
@export var item_functions: Resource

func _ready() -> void:
	Events.itemCollected.connect(on_item_pickup)

func on_item_pickup(itemOnGround):
	var passiveItem = PassiveItem.new()
	passiveItem.name = itemOnGround.itemName
	itemOnGround.queue_free()
	if items_data.items[itemOnGround.itemName].procs == Enums.ItemProcs.PICKUP:
		item_functions[items_data.items[passiveItem.name].function + passiveItem.state].call({})

	Players.player.collectedItems.push_back(passiveItem)
	
