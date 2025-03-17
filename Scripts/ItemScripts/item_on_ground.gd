extends Node2D

@export var itemName: String
@export var itemsData: Resource
var itemCollected = false
func _ready() -> void:
	#set sprite
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if itemCollected:
		return
	if body is Player:
		Events.itemCollected.emit(self)
		itemCollected = true
