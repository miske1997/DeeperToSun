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
	
func get_stat(entity, statName: String):
	if entity is Player:
		pass
	if entity is EnemyBase:
		pass

func set_status_effect(enemyHit, effectName: String, duration: float, extend: bool):
	enemyHit.add_to_group(effectName)
	if enemyHit.has_meta(effectName + "Duration") and extend:
		enemyHit.set_meta(effectName + "Duration", enemyHit.get_meta(effectName + "Duration") + duration)
	else:
		enemyHit.set_meta(effectName + "Duration", duration)
