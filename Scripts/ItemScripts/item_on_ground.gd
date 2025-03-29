extends Node2D

@export var item: ItemConfig
var itemCollected = true
var itemSpritesFolder := "res://Assets/Items/"

func _ready() -> void:
	#set sprite
	if file_exsist(item.sprite):
		$Sprite2D.texture = load(itemSpritesFolder + item.sprite + ".png")
	await get_tree().create_timer(1).timeout
	itemCollected = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
	#if itemCollected:
		#return
	#if body is Player:
		#Events.itemCollected.emit(self)
		#itemCollected = true


func file_exsist(fileName) -> bool:
	return FileAccess.file_exists(itemSpritesFolder + item.sprite + ".png")

func _on_interact_interacted() -> void:
	if itemCollected:
		return
	Events.itemCollected.emit(self)
	itemCollected = true
