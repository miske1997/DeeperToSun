extends Node

var shaderFolder := "res://Materials/Shaders/"

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

func add_shader(object: CanvasItem, shaderName: String):
	var shader = load(shaderFolder + shaderName + ".tres").duplicate()
	object.material = shader
	if not shader.has_meta("Animated"):
		return
	get_tree().create_tween().tween_property(object, 'material:shader_parameter/' + shader.get_meta("Param"), shader.get_meta("Goal"), shader.get_meta("Time"))
	return shader.get_meta("Time")
	
func remove_shader(object: CanvasItem, shaderName: String):
	if object.material and object.material.resource_name == shaderName:
		object.material = null
	
func map_range(value: float, low1: float, high1: float, low2: float, high2: float):
	return low2 + (value - low1) * (high2 - low2) / (high1 - low1)
	
#func replase_shader(object, shaderName: String):
