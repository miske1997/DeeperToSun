extends Node2D


@onready var ui := $InteractUI
@onready var text := $InteractUI/Control/PanelContainer/HBoxContainer/InteractText
@onready var inputKey := $InteractUI/Control/PanelContainer/HBoxContainer/InteractKey

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var interactible: Interactible = get_closest_interactible(get_interactibles())
	if not interactible:
		ui.hide()
		return
	interactible.selected = true
	ui.show()
	text.text = interactible.interactText
	if Input.is_action_just_pressed("Interact"):
		interactible.interacted.emit()
	
func get_closest_interactible(interactibles: Array[Interactible]):
	var minDist := 100000.0
	var closest: Interactible = null
	for interactible in interactibles:
		if (global_position - interactible.global_position).length() < minDist:
			minDist = (global_position - interactible.global_position).length()
			closest = interactible
	return closest
	
func get_interactibles():
	var interactibles: Array[Interactible] = []
	for interactible: Interactible in get_tree().get_nodes_in_group("Interactible"):
		interactible.selected = false
		if not interactible.active or (global_position - interactible.global_position).length() > interactible.interactDistance:
			interactible.inRange = false
			continue
		interactible.inRange = true
		interactibles.push_back(interactible)
	return interactibles
