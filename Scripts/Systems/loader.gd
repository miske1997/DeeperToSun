extends Node

@export var initPlayerData: PlayerData

func _ready() -> void:
	load_save()
	Players.player = initPlayerData.duplicate()
	#await  get_tree().create_timer(1).timeout
	#initPlayerData.stats.controllers["AttackSpeed"].AddExpirationModifier("munem", 10, 3, Enums.StatModifyerType.MULTIPLY, 3.0)
	#await  get_tree().create_timer(2).timeout
	#initPlayerData.stats.controllers["AttackSpeed"].ChangeModifier("munem", 5)
	#await  get_tree().create_timer(1).timeout
	#initPlayerData.stats.controllers["AttackSpeed"].RemoveModifier("munem")
	
func load_save():
	pass
	#GameData.saveData = ResourceLoader.load("user://Saves/save.tscn")
