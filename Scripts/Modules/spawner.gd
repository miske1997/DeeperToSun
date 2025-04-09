extends Node

@export var enemyFolder: Node2D
@onready var enemyBuilder = $EnemyBuilder
@onready var roomStart: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomStart").position
@onready var roomEnd: Vector2 = get_tree().get_first_node_in_group("Room").get_node("RoomEnd").position
@onready var roomSize = roomEnd - roomStart

func spawn_enemies(waveConfig: WaveConfig):
	var i = 0
	for enemySpawn: EnemySpawn in  waveConfig.get_enemy_spawns():
		var delay: float = randf_range(waveConfig.spawnDelayRange.x, waveConfig.spawnDelayRange.y)
		spawn_enemy(enemySpawn.spawn, enemySpawn.enemy, enemySpawn.localPosition)
		i += 1
		await get_tree().create_timer(delay).timeout
		
		
func spawn_enemy(location: Vector2, enemyName: String, localSpawn: bool):

	var enemy = enemyBuilder.construct_enemy(enemyName)
	if localSpawn:
		enemy.position = Vector2(location.x * roomSize.x, location.y * roomSize.y) + roomStart
	else:
		enemy.position = location
	#add spawn animation
	enemyFolder.add_child(enemy)
	
func spawn_global_wave(wave: WaveConfig):
	pass
