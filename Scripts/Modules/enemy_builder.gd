extends Node

var enemyLoadFolder := "res://Prefabs/Enemies/"

func construct_enemy(enemyName: String):
	var enemy: EnemyBase = load(enemyLoadFolder + enemyName + ".tscn").instantiate()
	
	return enemy
