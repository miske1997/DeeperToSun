extends Node

var enemyLoadFolder := "res://Prefabs/Enemies/"

func construct_enemy(enemyConfig: EnemyConfig):
	var enemy: EnemyBase = load(enemyLoadFolder + enemyConfig.enemyName + ".tscn").instantiate()
	enemy.enemyConfig = enemyConfig
	
	return enemy
