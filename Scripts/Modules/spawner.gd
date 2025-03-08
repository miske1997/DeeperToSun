extends Node


@export var enemyFolder: Node2D
@onready var enemyBuilder = $EnemyBuilder
func spawn_enemies(waveConfig: WaveConfig):
	var i = 0
	for location: Vector2 in  waveConfig.spawnLocations:
		spawn_enemy(location, waveConfig.enemies[i])
		i += 1
		
		
func spawn_enemy(location: Vector2, enemyConfig: EnemyConfig):
	var enemy = enemyBuilder.construct_enemy(enemyConfig)
	enemy.position = location
	#add spawn animation
	enemyFolder.add_child(enemy)
	
