class_name Interactible extends Node2D

@export var interactDistance: float = 10.0
@export var interactText := "BUY"
@export var sprite : CanvasItem
var inRange := false
var active = true
var selected := false

signal interacted


func _process(delta: float) -> void:
	if not active:
		return
	if selected:
		Utills.add_shader(sprite, "outline")
	else:
		Utills.remove_shader(sprite, "outline")
