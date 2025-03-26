extends Node2D

@export var item: ItemConfig
var itemCollected = true

func _ready() -> void:
	#set sprite
	await get_tree().create_timer(1).timeout
	itemCollected = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if itemCollected:
		return
	if body is Player:
		Events.itemCollected.emit(self)
		itemCollected = true
