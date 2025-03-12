extends Node


func _ready() -> void:
	load_save()
	#Players
	
func load_save():
	GameData.saveData = ResourceLoader.load("user://Saves/save.tscn")
