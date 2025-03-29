extends Control

@export var actionName: String = ""
@export var actionKeyBind: String = ""
@export var actionSlotType := Enums.ActiveSlotType.ACTIVE

@onready var progressBar := $Panel/TextureProgressBar
@onready var cooldownTime := $Panel/Cooldown
@onready var itemSprite := $Panel/Sprite
var item_functions = load("res://Data/Items/item_functions.tres")
func _ready() -> void:
	while not Players.player:
		await get_tree().process_frame
	$Panel/Label.text = actionKeyBind
	if actionSlotType == Enums.ActiveSlotType.ACTIVE:
		Players.player.activeItemEquipped.connect(item_changed)
	elif actionSlotType == Enums.ActiveSlotType.CONSUMABLE:
		Players.player.consumableItemEquipped.connect(item_changed)
	else:
		pass

func get_item():
	if actionSlotType == Enums.ActiveSlotType.ACTIVE:
		return Players.player.equppedItem
	elif actionSlotType == Enums.ActiveSlotType.CONSUMABLE:
		return Players.player.equppedConsumable

func _process(delta: float) -> void:
	if not Players.player:
		return
	if get_item() is ActiveItem and get_item().cooldownRemaning > 0:
		get_item().cooldownRemaning -= delta
		progressBar.value = get_item().cooldownRemaning * 10
		cooldownTime.text = str(snapped(get_item().cooldownRemaning, 0.1))
		return
		
	cooldownTime.hide()
	if Input.is_action_just_pressed(actionName):
		useItem()

func item_changed(item):
	if not item:
		return
	itemSprite.show()
	if not item is ActiveItem:
		return
	if item.cooldownRemaning > 0:
		cooldownTime.show()
		progressBar.value = item.cooldownRemaning * 10
		progressBar.max_value = item.cooldown * 10
	else:
		cooldownTime.hide()
		progressBar.value = 0
		

func useItem():
	if actionSlotType == Enums.ActiveSlotType.ACTIVE:
		useActive()
	elif actionSlotType == Enums.ActiveSlotType.CONSUMABLE:
		useConsumable()

func useActive():
	var item = Players.player.equppedItem
	item.cooldownRemaning = item.cooldown
	progressBar.max_value = item.cooldownRemaning * 10
	progressBar.value = item.cooldownRemaning * 10
	item_functions[item.function].call({})
	cooldownTime.show()


	
func useConsumable():
	if not Players.player.equppedConsumable:
		return
	var item = Players.player.equppedConsumable
	item_functions[item.function].call({})
	Players.player.equppedConsumable = null
	itemSprite.hide()
	
