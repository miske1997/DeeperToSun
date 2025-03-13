extends Node

func object_has_signal( object: Object, signal_name: String ) -> bool:
	var list = object.get_signal_list()
	
	for signal_entry in list:
		if signal_entry["name"] == signal_name:
			return true
		
	return false
	
func _ready() -> void:
	var globalScene = preload("res://Scenes/global_scene.tscn").instantiate()
	for i in 10:
		await get_tree().process_frame
	get_tree().root.add_child(globalScene)
